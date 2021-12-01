module Day01

include("Part01.jl")
include("Part02.jl")

stripsplit(x, sep) = split(strip(x), sep)
inputpath = normpath(joinpath(@__FILE__,"..","..","..","inputs"))
input = open("$inputpath/Day01/Input01.txt") do f
    s = read(f, String)
    [parse(Int, d) for d in stripsplit(s, "\n")]
end

answer1 = part1(input)
answer2 = part2(input)

end # module
