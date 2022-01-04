module Part1

include("Solve.jl")

# Constants --------------------------------------------------------------------

#= Test input burrow state
| #############
| #...........#
| ###B#C#B#D###
|   #A#D#C#A#
|   #########
=#
const TESTBURROW = Burrow(
    Hallway(1),
    Hallway(2),                Hallway(3),
    Room(Amber, 1,  Bronze()), Room(Amber, 2,  Amber()),
    Hallway(4),                Hallway(5),
    Room(Bronze, 1, Copper()), Room(Bronze, 2, Desert()),
    Hallway(6),                Hallway(7),
    Room(Copper, 1, Bronze()), Room(Copper, 2, Copper()),
    Hallway(8),                Hallway(9),
    Room(Desert, 1, Desert()), Room(Desert, 2, Amber()),
    Hallway(10),               Hallway(11)
)

#= Real input burrow state
| #############
| #...........#
| ###B#C#B#D###
|   #A#D#C#A#
|   #########
=#
const REALBURROW = Burrow(
    Hallway(1),
    Hallway(2),                Hallway(3),
    Room(Amber, 1,  Desert()), Room(Amber, 2,  Bronze()),
    Hallway(4),                Hallway(5),
    Room(Bronze, 1, Bronze()), Room(Bronze, 2, Desert()),
    Hallway(6),                Hallway(7),
    Room(Copper, 1, Amber()),  Room(Copper, 2, Amber()),
    Hallway(8),                Hallway(9),
    Room(Desert, 1, Copper()), Room(Desert, 2, Copper()),
    Hallway(10),               Hallway(11)
)

# Each index in `NEIGHBORS` contains a vector of the indices that can be reached
# from a given index in `Burrow.locations`, given the standard configuration
# produced by `Burrow()`. This is a bit brittle, since this constant will need
# to change if the `Burrow.locations` order changes.
const NEIGHBORS = [
    [2], 
    [1, 3],   [2, 4, 6],    [3, 5],   [4],
    [3, 7],   [6, 8, 10],   [7, 9],   [8],
    [7, 11],  [10, 12, 14], [11, 13], [12],
    [11, 15], [14, 16, 18], [15, 17], [16],
    [15, 19], [18]
]

# We'll use the doorway indices to keep track of where the `Room`s are 
# in the `Burrow`
const DOORWAYS = Dict(
    Room{Amber}  => 3,  Room{Bronze} => 7,
    Room{Copper} => 11, Room{Desert} => 15
)

# Solve Part One ---------------------------------------------------------------

part1(test = false) = test ? solve(TESTBURROW) : solve(REALBURROW)

end # module
