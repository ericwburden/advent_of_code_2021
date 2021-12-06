module Day05

include("Ingest.jl")
inputdir = normpath(joinpath(@__FILE__,"..","..","..","inputs"))
inputpath = joinpath(inputdir, "Day05", "input.txt")
input = ingest(inputpath)

include("Part01.jl")
answer1a = part1_strategy1(input)
answer1b = part1_strategy2(input)
answer1c = part1_strategy3(input)
@assert answer1a == answer1b && answer1b == answer1c
answer1 = answer1a

include("Part02.jl")
answer2 = part2(input)

end # module
