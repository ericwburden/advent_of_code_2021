
# Shared code between modules Part1 and Part2 ==================================
# Part1 and Part2 are split into modules to help with namespacing 

using DataStructures: BinaryMinHeap

#= Data Structures -------------------------------------------------------------
| These are the data structures used to represent the problem space
=#

# The different kinds of Amphipod
abstract type Amphipod end
struct Amber  <: Amphipod end
struct Bronze <: Amphipod end
struct Copper <: Amphipod end
struct Desert <: Amphipod end

const MaybeAmphipod = Union{Nothing,Amphipod}

# A space in the burrow where an Amphipod can be
abstract type Location end
struct Hallway <: Location
    idx::Int64
    occupant::MaybeAmphipod
end
Hallway(idx) = Hallway(idx, nothing)

struct Room{T} <: Location
    amphitype::Type{T}
    idx::Int64
    occupant::MaybeAmphipod
end
Room(T, idx) = Room(T, idx, nothing)

# The burrow is represented by a statically sized Tuple of `Location`s
struct Burrow{N}
    locations::NTuple{N, Location}
end

Base.getindex(burrow::Burrow, idx::Int64) = burrow.locations[idx]
Base.isempty(location::Location)          = isnothing(location.occupant)
Base.length(burrow::Burrow)               = length(burrow.locations)


#= Movement Rules --------------------------------------------------------------
| Use the puzzle rules to determine whether or not an amphipod can move from
| one space to another with the following functions...
=#

doorway(room::Room) = DOORWAYS[typeof(room)]

# It is illegal to move from one hallway space to another hallway space
canmove(::Hallway, ::Hallway, ::Burrow) = false

# An amphipod will only leave their room if they do not match the room OR
# they are between the hallway and another amphipod who does not match the room
function canmove(room::Room, ::Hallway, burrow::Burrow) 
    # Can leave the room if the amphipod doesn't match the room type...
    room.occupant isa room.amphitype || return true
    
    # ...but if it does and it's in the last space, it's going to stay
    room.idx == 4 && return false

    # Can move from the first space in the room to the hallway if...
    # - the amphipod type does not match the room type (already checked)
    # - an amphipod in a later space does not match the room type
    doorwayidx = doorway(room)
    roomidx = doorwayidx + room.idx + 1
    while burrow[roomidx] isa typeof(room)
        nextroom = burrow[roomidx]
        occupant = nextroom.occupant
        occupant isa room.amphitype || return true
        roomidx += 1
    end

    # If all the following room spaces are filled with the right kind of
    # amphipod, then stay put
    return false
end

# There are multiple rules associated with moving from a hallway space into 
# a room...
function canmove(hallway::Hallway, room::Room, burrow::Burrow)
    # Can't move into either of the room spaces if the amphipod type doesn't
    # match the type of room...
    hallway.occupant isa room.amphitype || return false

    # ...which is the only requirement for the last space in the room
    room.idx == 4 && return true

    # Can move from the hallway into the first `Room` space if...
    # - the amphipod type matches the room type (already checked)
    # - all the later spaces are occupied by an amphipod of the
    # appropriate type
    doorwayidx = doorway(room)
    roomidx = doorwayidx + room.idx + 1
    while burrow[roomidx] isa typeof(room)
        nextroom = burrow[roomidx]
        occupant = nextroom.occupant
        isnothing(occupant)         && return false
        occupant isa room.amphitype || return false
        roomidx += 1
    end

    # If all the following room spaces are filled with the right kind of
    # amphipod, then `amphipod` can move into the room space
    return true
end

# Rules for moving from one room space to another room space
function canmove(room1::Room, room2::Room, burrow::Burrow)
    # Can't move from one space to another in the same room
    typeof(room1) == typeof(room2) && return false

    # Can't move from one room to another if the amphipod matches the 
    # starting room
    room1.occupant isa room1.amphitype && return false

    # Can't move into a room that the amphipod doesn't match
    room1.occupant isa room2.amphitype || return false

    # Can't move into a room space if any of the following spaces are empty
    # or occupied by the wrong kind of amphipod
    doorwayidx = doorway(room2)
    roomidx = doorwayidx + room2.idx + 1
    while burrow[roomidx] isa typeof(room2)
        nextroom = burrow[roomidx]
        occupant = nextroom.occupant
        isnothing(occupant)          && return false
        occupant isa room2.amphitype || return false
        roomidx += 1
    end

    return true
end


#= Swapping --------------------------------------------------------------------
| The following functions enable swapping the occupants at two locations in the
| burrow. Since the `Burrow` is immutable, this involves creating a new `Burrow`
| by iteration, while making the change.
=#

# Given a room and a possible Amphipod, return a version of that room occupied
# by the possible amphipod
replace(R::Room{Amber},  MA::MaybeAmphipod) = Room(Amber,  R.idx, MA)
replace(R::Room{Bronze}, MA::MaybeAmphipod) = Room(Bronze, R.idx, MA)
replace(R::Room{Copper}, MA::MaybeAmphipod) = Room(Copper, R.idx, MA)
replace(R::Room{Desert}, MA::MaybeAmphipod) = Room(Desert, R.idx, MA)
replace(H::Hallway,      MA::MaybeAmphipod) = Hallway(H.idx, MA)

# Iterator for swapping the possible amphipod in one location with the 
# possible amphipod in another location
struct BurrowSwap{N}
    locations::NTuple{N,Location}
    swap1::Pair{Int64,MaybeAmphipod}
    swap2::Pair{Int64,MaybeAmphipod}
end

# Needed to make the iterator work
Base.eltype(::BurrowSwap)     = Location
Base.length(iter::BurrowSwap) = length(iter.locations)

# Iterator implementation. This is mostly used to produce a new `Burrow` where
# the occupants of two locations are swapped.. Just returns the other locations
# as they are, in order. The locations to be swapped are replaced with a copy
# containing the intended occupant.
function Base.iterate(iter::BurrowSwap, state = 1)
    (swap1, swap2, locations) = (iter.swap1, iter.swap2, iter.locations)
    state > length(locations) && return nothing

    (idx1, idx2) = (swap1.first, swap2.first)
    location = locations[state]
    state == idx1 && return (replace(location, swap1.second), state + 1)
    state == idx2 && return (replace(location, swap2.second), state + 1)
    return (location, state + 1)
end

# Convenience function to conduct the swap, producing a new Burrow with the
# occupants in the locations indicated by `idx1` and `idx2` swapped.
function swap(burrow::Burrow, idx1::Int64, idx2::Int64)
    (occupant1, occupant2) = (burrow[idx1].occupant, burrow[idx2].occupant)
    constructor = BurrowSwap{length(burrow.locations)}
    swapper = constructor(burrow.locations, idx1 => occupant2, idx2 => occupant1)
    return Burrow(Tuple(l for l in swapper))
end


#= Generating States -----------------------------------------------------------
| This section defines functionality for determining the next possible `Burrow`
| states
=#

# A `Move` is a Tuple of movement cost and ending index
const Move = NTuple{2,Int64}
const COST = Dict(Amber() => 1, Bronze() => 10, Copper() => 100, Desert() => 1000)

# For a given burrow and location (indicated by `idx`), return the `Move`s that
# can be reached by the amphipod in the indicated location.
function nextmoves(burrow::Burrow, idx::Int64)
    amphipod = burrow[idx].occupant
    isnothing(amphipod) && return []

    # Starting at the indicated location, perform a breadth-first search for
    # all the spaces that can be reached from the given location. 
    movecost = COST[amphipod]
    queue    = Vector{Move}([(0, idx)])
    visited  = Set{Int64}()
    moves    = Set{Move}()

    while !isempty(queue)
        (cost, current) = pop!(queue)

        for neighbor in NEIGHBORS[current]
            neighbor ∈ visited && continue
            isempty(burrow[neighbor]) || continue

            nextcost = cost + movecost
            pushfirst!(queue, (nextcost, neighbor))

            # Don't keep any moves that would stop in a doorway.
            neighbor ∈ values(DOORWAYS) && continue
            canmove(burrow[idx], burrow[neighbor], burrow) || continue
            push!(moves, (nextcost, neighbor))
        end
        push!(visited, current)
    end
    return moves
end

# Starting with a given `Burrow`, try moving all the `Amphipod`s and return 
# all the new `Burrow`s (new states) that can be produced by moving the
# amphipods. We'll keep up with the `Burrow` states, the cost to get there,
# and the estimated distance from the desired `Burrow` state. We'll sort
# the `MetaBurrow`s by accrued movement cost in our algorithm.
const MetaBurrow = Tuple{Int,Burrow} # (cost, burrow)
Base.isless(lhs::MetaBurrow, rhs::MetaBurrow) = lhs[1] < rhs[1]

function nextburrows(burrow::Burrow)
    burrows = Set{MetaBurrow}()

    for idx in 1:length(burrow)
        moves = nextmoves(burrow, idx)
        for (movecost, nextidx) in moves
            nextburrow = swap(burrow, idx, nextidx)
            push!(burrows, (movecost, nextburrow))
        end
    end
    return burrows
end

function isdone(burrow::Burrow)
    for location in burrow.locations
        location isa Hallway && continue
        location.occupant isa location.amphitype || return false
    end
    return true
end


#= Solve the puzzle ------------------------------------------------------------
| Solve using a "best-first" search strategy, where all the states that can
| be reached from current state are added to a BinaryMinHeap, and the state
| with the lowest cost is taken as the next state to check. Repeat until the
| final state is found. The distance heuristic is useful for skipping
| neighbors to check, reducing the total search space.
=#

function solve(initial)
    heap = BinaryMinHeap([(0, initial)])
    seen = Set{Burrow}()

    while !isempty(heap) 
        (cost, current) = pop!(heap)
        current ∈ seen  && continue
        isdone(current) && return cost
        push!(seen, current)

        for (burrowcost, nextburrow) in nextburrows(current)
            nextcost = cost + burrowcost
            push!(heap, (nextcost, nextburrow))
        end

    end
    error("Could not solve this input!")
end
