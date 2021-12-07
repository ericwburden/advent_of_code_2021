module Day04
using ..JuliaAdventOfCode: getinput

include("Ingest.jl")
inputpath = getinput("Day04", "input")
(numbers, boards) = ingest(inputpath)

include("Part01.jl")
boardscopy = deepcopy(boards)
answer1 = part1(numbers, boardscopy)

include("Part02.jl")
answer2 = part2(numbers, boards)

end # module
