module Day02
using ..JuliaAdventOfCode: getinput

include("Ingest.jl")
inputpath = getinput("Day02", "input")
input = ingest(inputpath)

# Strategy 3 is the fastest
include("Part01.jl")
answer1 = part1_strategy3(input)

# Strategy 3 is the fastest for Part 2, too
include("Part02.jl")
answer2 = part2_strategy3(input)

end # module
