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


# Day 04 ----------------------------------------------------------------------

include("Day04/Day04.jl")

println("\nDay 04")
println("├─ Part 01: $(Day04.answer1)")
println("└─ Part 02: $(Day04.answer2)")


# Day 05 ----------------------------------------------------------------------

include("Day05/Day05.jl")

println("\nDay 05")
println("├─ Part 01: $(Day05.answer1)")
println("└─ Part 02: $(Day05.answer2)")

end # module
