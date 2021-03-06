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


# Day 14 ----------------------------------------------------------------------

if day == 0 || day == 14
    inputpath = getinput("Day14", "input")
    input = Day14.ingest(inputpath)
    answer1 = Day14.part1(input)
    answer2 = Day14.part2(input)

    println("\nDay 14")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 15 ----------------------------------------------------------------------

if day == 0 || day == 15
    inputpath = getinput("Day15", "input")
    input = Day15.ingest(inputpath)
    answer1 = Day15.part1(input)
    answer2 = Day15.part2(input)

    println("\nDay 15")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 16 ----------------------------------------------------------------------

if day == 0 || day == 16
    inputpath = getinput("Day16", "input")
    input = Day16.ingest(inputpath)
    answer1 = Day16.part1(input)
    answer2 = Day16.part2(input)

    println("\nDay 16")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 17 ----------------------------------------------------------------------

if day == 0 || day == 17
    inputpath = getinput("Day17", "input")
    input = Day17.ingest(inputpath)
    answer1 = Day17.part1(input)
    answer2 = Day17.part2(input)

    println("\nDay 17")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 18 ----------------------------------------------------------------------

if day == 0 || day == 18
    inputpath = getinput("Day18", "input")
    input = Day18.ingest(inputpath)
    answer1 = Day18.part1(input)
    answer2 = Day18.part2(input)

    println("\nDay 18")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 19 ----------------------------------------------------------------------

if day == 0 || day == 19
    inputpath = getinput("Day19", "input")
    input = Day19.ingest(inputpath)
    (mapped, offsets) = Day19.mapscanners(input)
    answer1 = Day19.part1(mapped)
    answer2 = Day19.part2(offsets)

    println("\nDay 19")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 20 ----------------------------------------------------------------------

if day == 0 || day == 20
    inputpath = getinput("Day20", "input")
    input = Day20.ingest(inputpath)
    answer1 = Day20.solve(input, 2)
    answer2 = Day20.solve(input, 50)

    println("\nDay 20")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 21 ----------------------------------------------------------------------

if day == 0 || day == 21
    inputpath = getinput("Day21", "input")
    input = Day21.ingest(inputpath)
    answer1 = Day21.part1(input)
    answer2 = Day21.part2(input)

    println("\nDay 21")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 22 ----------------------------------------------------------------------

if day == 0 || day == 22
    inputpath = getinput("Day22", "input")
    input = Day22.ingest(inputpath)
    answer1 = Day22.part1(input)
    answer2 = Day22.part2(input)

    println("\nDay 22")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 23 ----------------------------------------------------------------------

if day == 0 || day == 23
    answer1 = Day23.Part1.part1()
    answer2 = Day23.Part2.part2()

    println("\nDay 23")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 24 ----------------------------------------------------------------------

if day == 0 || day == 24
    (answer1, answer2) = Day24.solve()

    println("\nDay 24")
    println("├─ Part 01: $(answer1)")
    println("└─ Part 02: $(answer2)")
end


# Day 25 ----------------------------------------------------------------------

if day == 0 || day == 25
    inputpath = getinput("Day25", "input")
    input = Day25.ingest(inputpath)
    answer = Day25.part1(input)

    println("\nDay 25")
    println("└─ Part 01: $(answer)")
end