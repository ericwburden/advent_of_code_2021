
# Shared code between modules Part1 and Part2 ==================================
# Part1 and Part2 are split into modules to help with namespacing the 
# `SPACEMAP`s and various `canmove()` methods.

using DataStructures: BinaryMinHeap
include("Ingest.jl")


# Shared Constants -------------------------------------------------------------

const COST = Dict(Amber => 1, Bronze => 10, Copper => 100, Desert => 1000)
const DOORWAYS = Set{Space}([Hallway(3), Hallway(5), Hallway(7), Hallway(9)])
const ROOMTYPES = [AmberRoom, BronzeRoom, CopperRoom, DesertRoom]


# Shared Utility Functions -----------------------------------------------------

# Use these functions to determine if the amphipod in a room space is the
# appropriate amphipod for that room...

# Multiple dispatch means that the first four methods will only be
# called if the argument types match exactly, while the last one is
# more generic and thus is called whenever they don't match.
matches(::Amber,    ::AmberRoom)  = true
matches(::Bronze,   ::BronzeRoom) = true
matches(::Copper,   ::CopperRoom) = true
matches(::Desert,   ::DesertRoom) = true
matches(::Amphipod, ::Room)       = false
matches(::Amphipod, ::Hallway)    = false
matches(::Nothing,  ::Room)       = false
matches(::Nothing,  ::Hallway)    = true


# A `Move` is a tuple of movement cost and ending space
const Move = Tuple{Int64,Space}

# From a given starting `Space`, identify all the valid moves from that space 
# to other, empty spaces on the board. Return a list of valid moves.
function movesfrom(start::Space, state::State)
    amphipod = state[start]
    movecost = COST[typeof(amphipod)]

    queue = Vector{Move}([(0, start)])
    visited = Set{Space}()
    moves = Set{Move}()

    while !isempty(queue)
        (cost, current) = pop!(queue)

        for stop in SPACEMAP[current]
            stop ∈ visited && continue          # Already visited
            isnothing(state[stop]) || continue  # Must be unoccupied

            # Cumulative cost for this move
            nextcost = cost + movecost
            pushfirst!(queue, (nextcost, stop))

            stop ∈ DOORWAYS && continue
            canmove(amphipod, start, stop, state) || continue
            push!(moves, (nextcost, stop))
        end
        push!(visited, current)
    end
    return moves
end

# Used to attach metadata to the state for "best-first" searching. In particular,
# the "best" next candidate to try when searching for the solution will be the
# state with the lowest total score + penalty.
const MetaState = Tuple{Int,State}  # penalty, score, state
Base.isless(a::MetaState, b::MetaState) = a[1] < b[1]

# Given a starting state, return all the `MetaState`s for states that can be
# reached by valid moves that can be taken by amphipods in the starting state.
function statesfrom(state::State)
    states = []

    for (start, amphipod) in state
        isnothing(amphipod) && continue
        moves = movesfrom(start, state)
        for (movecost, stop) in moves
            newstate = deepcopy(state)
            newstate[start] = nothing
            newstate[stop] = amphipod

            push!(states, (movecost, newstate))
        end
    end

    return states
end

# Check a given board state to see if it's "done", i.e., all the amphipods
# are in the correct rooms.
function isdone(state::State)
    for roomtype in ROOMTYPES
        room = roomtype(1)
        while haskey(state, room)
            occupant = state[room]
            matches(occupant, room) || return false
            room = roomtype(room.idx + 1)
        end
    end
    return true
end


# Solve the puzzle -------------------------------------------------------------

# Solve using a "best-first" search strategy, where all the states that can
# be reached from current state are added to a BinaryMinHeap, and the state
# with the lowest cost is taken as the next state to check. Repeat until the
# final state is found.
function solve(initial)
    heap = BinaryMinHeap([(0, initial)])
    seen = Set{State}()
    while !isempty(heap) 
        (cost, current) = pop!(heap)
        current ∈ seen && continue
        isdone(current) && return cost

        for (statecost, nextstate) in statesfrom(current)
            nextcost = cost + statecost
            push!(heap, (nextcost, nextstate))
        end

        push!(seen, current)
    end
    error("Failed to find a solution!")
end