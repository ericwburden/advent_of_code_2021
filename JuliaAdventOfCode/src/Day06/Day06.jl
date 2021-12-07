module Day06
using ..JuliaAdventOfCode: getinput

include("Ingest.jl")
inputpath = getinput("Day06", "input")
input = ingest(inputpath)

include("Solve.jl")
answer1 = solve(input, 80)
answer2 = solve(input, 256)

end # module
