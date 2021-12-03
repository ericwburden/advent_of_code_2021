module JuliaAdventOfCode

println("\nAdvent of Code 2021 Results:")


# Day 01 ----------------------------------------------------------------------

include("Day01/Day01.jl")

println("\nDay 01")
println("├─ Part 01: $(Day01.answer1)")
println("└─ Part 02: $(Day01.answer2)")


# Day 02 ----------------------------------------------------------------------

include("Day02/Day02.jl")

println("\nDay 02")
println("├─ Part 01: $(Day02.answer1)")
println("└─ Part 02: $(Day02.answer2)")


# Day 03 ----------------------------------------------------------------------

include("Day03/Day03.jl")

println("\nDay 03")
println("├─ Part 01: $(Day03.answer1)")
println("└─ Part 02: $(Day03.answer2)")

end # module
