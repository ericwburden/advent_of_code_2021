module Day07

include("Ingest.jl")
inputdir = normpath(joinpath(@__FILE__,"..","..","..","inputs"))
inputpath = joinpath(inputdir, "Day07", "input.txt")
input = ingest(inputpath)

include("Part01.jl")
answer1 = part1(input)

include("Part02.jl")
answer2 = part2(input)

end # module
