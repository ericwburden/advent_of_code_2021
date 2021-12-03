module Day03

function process(s::AbstractString)::Vector{Bool}
    split(s, "") .== "1"
end

inputdir = normpath(joinpath(@__FILE__,"..","..","..","inputs"))
inputpath = joinpath(inputdir, "Day03", "input.txt")
input = open(inputpath) do f
    # Get a Vector of Boolean vectors, convert to a BitMatrix,
    # then transpose it such that the first column contains the 
    # first bit of every number, the second column contains the
    # second bit, etc.
    bitvecs = [process(s) for s in readlines(f)]
    bitmatrix = reduce(hcat, bitvecs)
    transpose(bitmatrix)
end

include("Part01.jl")
answer1 = part1(input)

include("Part02.jl")
answer2 = part2(input)

end # module
