module Day03
using ..JuliaAdventOfCode: getinput

include("Ingest.jl")
inputpath = getinput("Day03", "input")
input = ingest(inputpath)

include("Part01.jl")
answer1 = part1(input)

include("Part02.jl")
answer2 = part2(input)

end # module
