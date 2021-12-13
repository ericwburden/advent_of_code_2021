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
    inputpath = getinput("Day01", "input")
    input = Day01.ingest(inputpath)
    answer1 = Day01.part1(input)
    answer2 = Day01.part2(input)

    println("\nDay 01")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 02 ----------------------------------------------------------------------

if day == 0 || day == 2
    inputpath = getinput("Day02", "input")
    input = Day02.ingest(inputpath)
    answer1 = Day02.part1_strategy3(input)
    answer2 = Day02.part2_strategy3(input)

    println("\nDay 02")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 03 ----------------------------------------------------------------------

if day == 0 || day == 3
    inputpath = getinput("Day03", "input")
    input = Day03.ingest(inputpath)
    answer1 = Day03.part1(input)
    answer2 = Day03.part2(input)

    println("\nDay 03")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 04 ----------------------------------------------------------------------

if day == 0 || day == 4
    inputpath = getinput("Day04", "input")
    (numbers, boards) = Day04.ingest(inputpath)
    boardscopy = deepcopy(boards)
    answer1 = Day04.part1(numbers, boards)
    answer2 = Day04.part2(numbers, boardscopy)

    println("\nDay 04")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 05 ----------------------------------------------------------------------

if day == 0 || day == 5
    inputpath = getinput("Day05", "input")
    input = Day05.ingest(inputpath)
    answer1 = Day05.part1_strategy3(input)
    answer2 = Day05.part2(input)

    println("\nDay 05")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 06 ----------------------------------------------------------------------

if day == 0 || day == 6
    inputpath = getinput("Day06", "input")
    input = Day06.ingest(inputpath)
    answer1 = Day06.solve(input, 80)
    answer2 = Day06.solve(input, 256)

    println("\nDay 06")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 07 ----------------------------------------------------------------------

if day == 0 || day == 7
    inputpath = getinput("Day07", "input")
    input = Day07.ingest(inputpath)
    answer1 = Day07.part1(input)
    answer2 = Day07.part2(input)

    println("\nDay 07")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 08 ----------------------------------------------------------------------

if day == 0 || day == 8
    inputpath = getinput("Day08", "input")
    input = Day08.ingest(inputpath)
    answer1 = Day08.part1(input)
    answer2 = Day08.part2(input)

    println("\nDay 08")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 09 ----------------------------------------------------------------------

if day == 0 || day == 9
    inputpath = getinput("Day09", "input")
    input = Day09.ingest(inputpath)
    answer1 = Day09.part1(input)
    answer2 = Day09.part2(input)

    println("\nDay 09")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 10 ----------------------------------------------------------------------

if day == 0 || day == 10
    inputpath = getinput("Day10", "input")
    input = Day10.ingest(inputpath)
    answer1 = Day10.part1(input)
    answer2 = Day10.part2(input)

    println("\nDay 10")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 11 ----------------------------------------------------------------------

if day == 0 || day == 11
    inputpath = getinput("Day11", "input")
    input = Day11.ingest(inputpath)
    answer1 = Day11.part1(input)
    answer2 = Day11.part2(input)

    println("\nDay 11")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 12 ----------------------------------------------------------------------

if day == 0 || day == 12
    inputpath = getinput("Day12", "input")
    input = Day12.ingest(inputpath)
    answer1 = Day12.part1(input)
    answer2 = Day12.part2(input)

    println("\nDay 12")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 13 ----------------------------------------------------------------------

if day == 0 || day == 13
    inputpath = getinput("Day13", "input")
    input = Day13.ingest(inputpath)
    answer1 = Day13.part1(input)
    answer2 = Day13.part2(input)

    println("\nDay 13")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end