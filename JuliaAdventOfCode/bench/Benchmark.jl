srcpath = normpath(joinpath(@__FILE__,"..","..","src"))

println("\nJulia Advent of Code 2021 Benchmarks:\n")

# Day 01 ----------------------------------------------------------------------

include("$srcpath/Day01/Day01.jl")
println("- Day 01:")

print("|-- Part 01:")
@time Day01.part1(Day01.input)

print("|-- Part 02:")
@time Day01.part2(Day01.input)

println()