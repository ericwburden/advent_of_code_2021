module JuliaAdventOfCode

inputdirpath = normpath(joinpath(@__FILE__,"..","..","inputs"))
getinput(d, fn) = joinpath(inputdirpath, d, "$fn.txt")
export getinput

println("\nAdvent of Code 2021 Results:")


# Day 01 ----------------------------------------------------------------------

include("Day01/Day01.jl")
export Day01

println("\nDay 01")
println("├─ Part 01: $(Day01.answer1)")
println("└─ Part 02: $(Day01.answer2)")


# Day 02 ----------------------------------------------------------------------

include("Day02/Day02.jl")
export Day02

println("\nDay 02")
println("├─ Part 01: $(Day02.answer1)")
println("└─ Part 02: $(Day02.answer2)")


# Day 03 ----------------------------------------------------------------------

include("Day03/Day03.jl")
export Day03

println("\nDay 03")
println("├─ Part 01: $(Day03.answer1)")
println("└─ Part 02: $(Day03.answer2)")


# Day 04 ----------------------------------------------------------------------

include("Day04/Day04.jl")
export Day04

println("\nDay 04")
println("├─ Part 01: $(Day04.answer1)")
println("└─ Part 02: $(Day04.answer2)")


# Day 05 ----------------------------------------------------------------------

include("Day05/Day05.jl")
export Day05

println("\nDay 05")
println("├─ Part 01: $(Day05.answer1)")
println("└─ Part 02: $(Day05.answer2)")


# Day 06 ----------------------------------------------------------------------

include("Day06/Day06.jl")
export Day06

println("\nDay 06")
println("├─ Part 01: $(Day06.answer1)")
println("└─ Part 02: $(Day06.answer2)")


# Day 07 ----------------------------------------------------------------------

include("Day07/Day07.jl")
export Day07

println("\nDay 07")
println("├─ Part 01: $(Day07.answer1)")
println("└─ Part 02: $(Day07.answer2)")

end # module
