module Day01

include("Part01.jl")
include("Part02.jl")

inputpath = normpath(joinpath(@__FILE__,"..","..","..","inputs"))
input = open("$inputpath/Day01/Input01.txt") do f
    [parse(Int, s) for s in readlines(f)]
end

answer1 = part1(input)
answer2 = part2(input)

end # module
