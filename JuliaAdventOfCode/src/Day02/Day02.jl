module Day02

abstract type AbstractDirection end

struct Forward <: AbstractDirection mag::Integer end
struct Down    <: AbstractDirection mag::Integer end
struct Up      <: AbstractDirection mag::Integer end

function todirection(s::AbstractString)::AbstractDirection
    (dirstr, magstr) = split(s)
    mag = parse(Int, magstr)
    dirstr == "forward" && return Forward(mag)
    dirstr == "down"    && return Down(mag)
    dirstr == "up"      && return Up(mag)
    DomainError(s, "cannot be converted to Direction") |> throw
end

inputdir = normpath(joinpath(@__FILE__,"..","..","..","inputs"))
inputpath = joinpath(inputdir, "Day02", "Input01.txt")
input = open(inputpath) do f
    [todirection(s) for s in readlines(f)]
end

# Get the answer to the first part. Need to be sure all the strategies provide
# the same answer.
include("Part01.jl")

@assert part1_strategy1(input) == part1_strategy2(input)
@assert part1_strategy2(input) == part1_strategy3(input)
answer1 = part1_strategy1(input)


# Get the answer to the second part. Need to be sure all the strategies provide
# the same answer.
include("Part02.jl")

@assert part2_strategy1(input) == part2_strategy2(input)
@assert part2_strategy2(input) == part2_strategy3(input)
answer2 = part2_strategy1(input)

end # module
