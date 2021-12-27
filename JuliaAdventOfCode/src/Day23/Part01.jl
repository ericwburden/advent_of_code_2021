module Part1

include("Solve.jl")

# Constants --------------------------------------------------------------------

const SPACEMAP = Dict{Space,Vector{Space}}(
    Hallway(1)    => [Hallway(2)],
    Hallway(2)    => [Hallway(1), Hallway(3)],
    Hallway(3)    => [Hallway(2), AmberRoom(1),  Hallway(4)],
    AmberRoom(1)  => [Hallway(3), AmberRoom(2)],
    AmberRoom(2)  => [AmberRoom( 1)],
    Hallway(4)    => [Hallway(3), Hallway(5)],
    Hallway(5)    => [Hallway(4), BronzeRoom(1), Hallway(6)],
    BronzeRoom(1) => [Hallway(5), BronzeRoom(2)],
    BronzeRoom(2) => [BronzeRoom(1)],
    Hallway(6)    => [Hallway(5), Hallway(7)],
    Hallway(7)    => [Hallway(6), CopperRoom(1), Hallway(8)],
    CopperRoom(1) => [Hallway(7), CopperRoom(2)],
    CopperRoom(2) => [CopperRoom(1)],
    Hallway(8)    => [Hallway(7), Hallway(9)],
    Hallway(9)    => [Hallway(8), DesertRoom(1), Hallway(10)],
    DesertRoom(1) => [Hallway(9), DesertRoom(2)],
    DesertRoom(2) => [DesertRoom(1)],
    Hallway(10)   => [Hallway(9), Hallway(11)],
    Hallway(11)   => [Hallway(10)]
)


# Helper Functions -------------------------------------------------------------

# Use the puzzle rules to determine whether or not an amphipod can move from
# one space to another with the following functions...

# It is illegal to move from one hallway space to another hallway space
canmove(::Amphipod, ::Hallway, ::Hallway, ::State) = false

# An amphipod will only leave their room if they do not match the room OR
# they are between the hallway and another amphipod who does not match the room
function canmove(amphipod::Amphipod, room::Room, ::Hallway, state::State) 
    # Can leave the room if the amphipod doesn't match the room type...
    matches(amphipod, room) || return true
    
    # ...but if it does and it's in the second space, it's going to stay
    room.idx == 2 && return false

    # Can move from the first space in the room to the hallway if...
    # - the amphipod type does not match the room type (already checked)
    # - the amphipod in the second space does not match the room type
    lastspace = getlastspace(room)
    occupant = state[lastspace]
    return !matches(occupant, room)
end

# There are multiple rules associated with moving from a hallway space into 
# a room...
function canmove(amphipod::Amphipod, ::Hallway, room::Room, state::State)
    # Can't move into either of the room spaces if the amphipod type doesn't
    # match the type of room...
    matches(amphipod, room) || return false

    # ...which is the only requirement for the last space in the room
    room.idx == 2 && return true

    # Can move from the hallway into the first `Room` space if...
    # - the amphipod type matches the room type (already checked)
    # - the last room space is occupied by an amphipod of the appropriate type
    lastspace = getlastspace(room)
    occupant = state[lastspace]
    return (!isnothing(occupant) && matches(occupant, room))
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

    # Can't move into the first space of a new room if the second
    # space is unoccupied
    lastspace2 = getlastspace(room2)
    occupant = state[lastspace2]
    room2.idx == 1 && isnothing(occupant) && return false

    return true
end

# It's convenient to access the last space in the room directly
getlastspace(::AmberRoom)  = AmberRoom(2)
getlastspace(::BronzeRoom) = BronzeRoom(2)
getlastspace(::CopperRoom) = CopperRoom(2)
getlastspace(::DesertRoom) = DesertRoom(2)


# Solve Part One ---------------------------------------------------------------

part1(initial::State) = solve(initial)

end # module
