module Part2

include("Solve.jl")


# Constants --------------------------------------------------------------------

const SPACEMAP = Dict{Space,Vector{Space}}(
    Hallway(1)    => [Hallway(2)],
    Hallway(2)    => [Hallway(1),    Hallway(3)],
    Hallway(3)    => [Hallway(2),    AmberRoom(1),  Hallway(4)],
    AmberRoom(1)  => [Hallway(3),    AmberRoom(2)],
    AmberRoom(2)  => [AmberRoom(1),  AmberRoom(3)],
    AmberRoom(3)  => [AmberRoom(2),  AmberRoom(4)],
    AmberRoom(4)  => [AmberRoom(3)],
    Hallway(4)    => [Hallway(3),    Hallway(5)],
    Hallway(5)    => [Hallway(4),    BronzeRoom(1), Hallway(6)],
    BronzeRoom(1) => [Hallway(5),    BronzeRoom(2)],
    BronzeRoom(2) => [BronzeRoom(1), BronzeRoom(3)],
    BronzeRoom(3) => [BronzeRoom(2), BronzeRoom(4)],
    BronzeRoom(4) => [BronzeRoom(3)],
    Hallway(6)    => [Hallway(5),    Hallway(7)],
    Hallway(7)    => [Hallway(6),    CopperRoom(1), Hallway(8)],
    CopperRoom(1) => [Hallway(7),    CopperRoom(2)],
    CopperRoom(2) => [CopperRoom(1), CopperRoom(3)],
    CopperRoom(3) => [CopperRoom(2), CopperRoom(4)],
    CopperRoom(4) => [CopperRoom(3)],
    Hallway(8)    => [Hallway(7),    Hallway(9)],
    Hallway(9)    => [Hallway(8),    DesertRoom(1), Hallway(10)],
    DesertRoom(1) => [Hallway(9),    DesertRoom(2)],
    DesertRoom(2) => [DesertRoom(1), DesertRoom(3)],
    DesertRoom(3) => [DesertRoom(2), DesertRoom(4)],
    DesertRoom(4) => [DesertRoom(3)],
    Hallway(10)   => [Hallway(9), Hallway(11)],
    Hallway(11)   => [Hallway(10)]
)


# Helper Functions -------------------------------------------------------------

# Add the two extra room spaces between the first and *previous* second spaces
function unfold!(state::State)
    # Move everything from the second room space to the fourth
    state[AmberRoom(4)]  = state[AmberRoom(2)]
    state[BronzeRoom(4)] = state[BronzeRoom(2)]
    state[CopperRoom(4)] = state[CopperRoom(2)]
    state[DesertRoom(4)] = state[DesertRoom(2)]

    # Add the extra rows
    state[AmberRoom(2)]  = Desert()
    state[BronzeRoom(2)] = Copper()
    state[CopperRoom(2)] = Bronze()
    state[DesertRoom(2)] = Amber()

    state[AmberRoom(3)]  = Desert()
    state[BronzeRoom(3)] = Bronze()
    state[CopperRoom(3)] = Amber()
    state[DesertRoom(3)] = Copper()
end


# We need to adjust the rules a bit to account for the new room spaces

# It is _still_ illegal to move from one hallway space to another hallway space
canmove(::Amphipod, ::Hallway, ::Hallway, ::State) = false

# An amphipod will only leave their room if they do not match the room OR
# they are between the hallway and another amphipod who does not match the room
function canmove(amphipod::Amphipod, room::Room, ::Hallway, state::State) 
    # Can leave the room if the amphipod doesn't match the room type...
    matches(amphipod, room) || return true
    
    # ...but if it does and it's in the last space, it's going to stay
    room.idx == 4 && return false

    # Can move from a space in the room to the hallway if...
    # - the amphipod type does not match the room type (already checked)
    # - an amphipod in a later space does not match the room type
    nextspace = getnextspace(room)
    while !isnothing(nextspace)
        occupant = state[nextspace]
        !matches(occupant, room) && return true
        nextspace = getnextspace(nextspace)
    end

    # If all the following room spaces are filled with the right kind of
    # amphipod, then stay put
    return false
end

# There are multiple rules associated with moving from a hallway space into 
# a room...
function canmove(amphipod::Amphipod, ::Hallway, room::Room, state::State)
    # Can't move into either of the room spaces if the amphipod type doesn't
    # match the type of room...
    matches(amphipod, room) || return false

    # ...which is the only requirement for the last space in the room
    room.idx == 4 && return true

    # Can move from the hallway into a `Room` space if...
    # - the amphipod type matches the room type (already checked)
    # - the all the later spaces are occupied by an amphipod of the
    # appropriate type
    nextspace = getnextspace(room)
    while !isnothing(nextspace)
        occupant = state[nextspace]
        isnothing(occupant)      && return false
        !matches(occupant, nextspace) && return false
        nextspace = getnextspace(nextspace)
    end

    # If all the following room spaces are filled with the right kind of
    # amphipod, then `amphipod` can move into the room space
    return true
end

# Rules for moving from one room space to another room space
function canmove(amphipod::Amphipod, room1::Room, room2::Room, state::State)
    # Can't move from one space to another in the same room
    typeof(room1) == typeof(room2) && return false

    # Can't move from one room to another if the amphipod matches the 
    # starting room
    matches(amphipod, room1) && return false

    # Can't move into a room that the amphipod doesn't match
    matches(amphipod, room2) || return false

    # Can't move into a room space if any of the following spaces are empty
    # or occupied by the wrong kind of amphipod
    nextspace = getnextspace(room2)
    while !isnothing(nextspace)
        occupant = state[nextspace]
        isnothing(occupant)      && return false
        !matches(occupant, nextspace) && return false
        nextspace = getnextspace(nextspace)
    end

    return true
end

# It is convenient to be able to get the room space after the current one, i.e.
# get an AmberRoom(3) from an AmberRoom(2)
getnextspace(R::AmberRoom)  = R.idx < 4 ? AmberRoom(R.idx + 1)  : nothing
getnextspace(R::BronzeRoom) = R.idx < 4 ? BronzeRoom(R.idx + 1) : nothing
getnextspace(R::CopperRoom) = R.idx < 4 ? CopperRoom(R.idx + 1) : nothing
getnextspace(R::DesertRoom) = R.idx < 4 ? DesertRoom(R.idx + 1) : nothing


# Solve Part Two ---------------------------------------------------------------

# Solve using a "best-first" search strategy, where all the states that can
# be reached from current state are added to a BinaryMinHeap, and the state
# with the lowest cost is taken as the next state to check. Repeat until the
# final state is found.
function part2(initial)
    initial = deepcopy(initial)
    unfold!(initial)
    return solve(initial)
end

end # module
