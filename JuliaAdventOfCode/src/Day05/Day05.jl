module Day05
using ..JuliaAdventOfCode: getinput

include("Ingest.jl")
inputpath = getinput("Day05", "input")
input = ingest(inputpath)

# Strategy 3 is the fastest
include("Part01.jl")
answer1 = part1_strategy3(input)

# Only one strategy for this one
include("Part02.jl")
answer2 = part2(input)

end # module
