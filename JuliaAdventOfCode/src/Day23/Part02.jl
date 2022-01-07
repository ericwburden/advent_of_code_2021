module Part2

include("Solve.jl")


#= Hardcoded Inputs ------------------------------------------------------------
| It was convenient for this puzzle to simply create the objects in code.
=#

#= Test input burrow state
| #############
| #...........#
| ###B#C#B#D###
|   #D#C#B#A#
|   #D#B#A#C#
|   #A#D#C#A#
|   #########
=#
const TESTBURROW = Burrow(
    Hallway(1),
    Hallway(2),                Hallway(3),
    Room(Amber, 1,  Bronze()), Room(Amber, 2,  Desert()),
    Room(Amber, 3,  Desert()), Room(Amber, 4,  Amber()),
    Hallway(4),                Hallway(5),
    Room(Bronze, 1, Copper()), Room(Bronze, 2, Copper()),
    Room(Bronze, 3, Bronze()), Room(Bronze, 4, Desert()),
    Hallway(6),                Hallway(7),
    Room(Copper, 1, Bronze()), Room(Copper, 2, Bronze()),
    Room(Copper, 3, Amber()),  Room(Copper, 4, Copper()),
    Hallway(8),                Hallway(9),
    Room(Desert, 1, Desert()), Room(Desert, 2, Amber()),
    Room(Desert, 3, Copper()), Room(Desert, 4, Amber()),
    Hallway(10),               Hallway(11)
)

#= Real input burrow state
| #############
| #...........#
| ###D#B#A#C###
|   #D#C#B#A#
|   #D#B#A#C#
|   #B#D#A#C#
|   #########
=#
const REALBURROW = Burrow(
    Hallway(1),
    Hallway(2),                Hallway(3),
    Room(Amber, 1,  Desert()), Room(Amber, 2,  Desert()),
    Room(Amber, 3,  Desert()), Room(Amber, 4,  Bronze()),
    Hallway(4),                Hallway(5),
    Room(Bronze, 1, Bronze()), Room(Bronze, 2, Copper()),
    Room(Bronze, 3, Bronze()), Room(Bronze, 4, Desert()),
    Hallway(6),                Hallway(7),
    Room(Copper, 1, Amber()),  Room(Copper, 2, Bronze()),
    Room(Copper, 3, Amber()),  Room(Copper, 4, Amber()),
    Hallway(8),                Hallway(9),
    Room(Desert, 1, Copper()), Room(Desert, 2, Amber()),
    Room(Desert, 3, Copper()), Room(Desert, 4, Copper()),
    Hallway(10),               Hallway(11)
)

# Each index in `NEIGHBORS` contains a vector of the indices that can be reached
# from a given index in `Burrow.locations`, given the standard configuration
# produced by `Burrow()`. This is a bit brittle, since this constant will need
# to change if the `Burrow.locations` order changes.
const NEIGHBORS = [
    [ 2],     [ 1,  3], [ 2,  4,  8], 
    [ 3,  5], [ 4,  6], [ 5,  7],
    [ 6],     [ 3,  9], [ 8, 10, 14],
    [ 9, 11], [10, 12], [11, 13],
    [12],     [ 9, 15], [14, 16, 20],
    [15, 17], [16, 18], [17, 19],
    [18],     [15, 21], [20, 22, 26],
    [21, 23], [22, 24], [23, 25],
    [24],     [21, 27], [26]
]

# We'll use the doorway indices to keep track of where the `Room`s are 
# in the `Burrow`
const DOORWAYS = Dict(
    Room{Amber}  => 3,  Room{Bronze} => 9,
    Room{Copper} => 15, Room{Desert} => 21
)

# Target room depth for estimating remaining distance
const ROOMDEPTH = 3

# Solve Part Two ---------------------------------------------------------------

part2(test = false) = test ? solve(TESTBURROW) : solve(REALBURROW)

end # module
