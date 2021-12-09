using ArgParse
using JuliaAdventOfCode


# ArgParse Settings -----------------------------------------------------------

settings = ArgParseSettings()
@add_arg_table! settings begin
    "--day", "-d"
    help = "Day to run"
    arg_type = Int
    default = 0
end

parsed_args = parse_args(settings)
day = parsed_args["day"]


println("\nAdvent of Code 2021 Results:")

# Day 01 ----------------------------------------------------------------------

if day == 0 || day == 1
    println("\nDay 01")
    println("├─ Part 01: $(Day01.answer1)")
    println("└─ Part 02: $(Day01.answer2)")
end


# Day 02 ----------------------------------------------------------------------

if day == 0 || day == 2
    println("\nDay 02")
    println("├─ Part 01: $(Day02.answer1)")
    println("└─ Part 02: $(Day02.answer2)")
end


# Day 03 ----------------------------------------------------------------------

if day == 0 || day == 3
    println("\nDay 03")
    println("├─ Part 01: $(Day03.answer1)")
    println("└─ Part 02: $(Day03.answer2)")
end


# Day 04 ----------------------------------------------------------------------

if day == 0 || day == 4
    println("\nDay 04")
    println("├─ Part 01: $(Day04.answer1)")
    println("└─ Part 02: $(Day04.answer2)")
end


# Day 05 ----------------------------------------------------------------------

if day == 0 || day == 5
    println("\nDay 05")
    println("├─ Part 01: $(Day05.answer1)")
    println("└─ Part 02: $(Day05.answer2)")
end


# Day 06 ----------------------------------------------------------------------

if day == 0 || day == 5
    println("\nDay 06")
    println("├─ Part 01: $(Day06.answer1)")
    println("└─ Part 02: $(Day06.answer2)")
end


# Day 07 ----------------------------------------------------------------------

if day == 0 || day == 5
    println("\nDay 07")
    println("├─ Part 01: $(Day07.answer1)")
    println("└─ Part 02: $(Day07.answer2)")
end


# Day 08 ----------------------------------------------------------------------

if day == 0 || day == 8
    println("\nDay 08")
    println("├─ Part 01: $(Day08.answer1)")
    println("└─ Part 02: $(Day08.answer2)")
end


# Day 09 ----------------------------------------------------------------------

if day == 0 || day == 9
    println("\nDay 09")
    println("├─ Part 01: $(Day09.answer1)")
    println("└─ Part 02: $(Day09.answer2)")
end