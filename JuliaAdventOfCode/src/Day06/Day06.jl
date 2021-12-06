module Day06

include("Ingest.jl")
inputdir = normpath(joinpath(@__FILE__,"..","..","..","inputs"))
inputpath = joinpath(inputdir, "Day06", "input.txt")
input = ingest(inputpath)

include("Solve.jl")
answer1 = solve(input, 80)
answer2 = solve(input, 256)

end # module
