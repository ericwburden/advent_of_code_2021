module JuliaAdventOfCode

println("\nAdvent of Code 2021 Results:\n")

# Day 01 ----------------------------------------------------------------------

include("Day01/Day01.jl")

println("- Day 01")
println("|-- Part 01: $(Day01.answer1)")
println("|-- Part 02: $(Day01.answer2)")

end # module
