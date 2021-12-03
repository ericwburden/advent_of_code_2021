module Day03

function process(s::AbstractString)
    missing
end

inputdir = normpath(joinpath(@__FILE__,"..","..","..","inputs"))
inputpath = joinpath(inputdir, "Day03", "Input01.txt")
input = open(inputpath) do f
    [process(s) for s in readlines(f)]
end

include("Part01.jl")
answer1 = part1(input)

include("Part02.jl")
answer2 = part2(input)

end # module
