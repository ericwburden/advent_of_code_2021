module Day04

inputdir = normpath(joinpath(@__FILE__,"..","..","..","inputs"))
inputpath = joinpath(inputdir, "Day04", "input.txt")
include("Ingest.jl")
(numbers, boards) = ingest(inputpath)

include("Part01.jl")
boardscopy = deepcopy(boards)
answer1 = part1(numbers, boardscopy)

include("Part02.jl")
answer2 = part2(numbers, boards)

end # module
