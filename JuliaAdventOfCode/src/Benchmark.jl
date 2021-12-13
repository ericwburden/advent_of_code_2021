using ArgParse
using BenchmarkTools
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


# Benchmarking Setup ----------------------------------------------------------

println("\nJulia Advent of Code 2021 Benchmarks:")

# Day 01 ----------------------------------------------------------------------

if day == 0 || day == 1
    inputpath = getinput("Day01", "input")
    input = Day01.ingest(inputpath)

    println("\nDay 01:")

    print("├─ Part 01:")
    @btime Day01.part1(input)

    print("└─ Part 02:")
    @btime Day01.part2(input)
end


# Day 02 ----------------------------------------------------------------------

if day == 0 || day == 2
    inputpath = getinput("Day02", "input")
    input = Day02.ingest(inputpath)

    println("\nDay 02:")

    # Part 1
    println("├─ Part 01:")

    print("│  ├─ Strategy 01:")
    @btime Day02.part1_strategy1(input)

    print("│  ├─ Strategy 02:")
    @btime Day02.part1_strategy2(input)

    print("│  └─ Strategy 03:")
    @btime Day02.part1_strategy3(input)

    # Part 2
    println("└─ Part 02:")

    print("   ├─ Strategy 01:")
    @btime Day02.part2_strategy1(input)

    print("   ├─ Strategy 02:")
    @btime Day02.part2_strategy2(input)

    print("   └─ Strategy 03:")
    @btime Day02.part2_strategy3(input)
end


# Day 03 ----------------------------------------------------------------------

if day == 0 || day == 3
    inputpath = getinput("Day03", "input")
    input = Day03.ingest(inputpath)

    println("\nDay 03:")

    print("├─ Part 01:")
    @btime Day03.part1(input)

    print("└─ Part 02:")
    @btime Day03.part2(input)
end


# Day 04 ----------------------------------------------------------------------

if day == 0 || day == 4
    inputpath = getinput("Day04", "input")
    (numbers, boards) = Day04.ingest(inputpath)
    boardscopy = deepcopy(boards)

    println("\nDay 04:")

    print("├─ Part 01:")
    @btime Day04.part1(numbers, boards)

    print("└─ Part 02:")
    @btime Day04.part2(numbers, boardscopy)
end


# Day 05 ----------------------------------------------------------------------

if day == 0 || day == 5
    inputpath = getinput("Day05", "input")
    input = Day05.ingest(inputpath)

    println("\nDay 05:")

    # Part 1
    println("├─ Part 01:")

    print("│  ├─ Strategy 01:")
    @btime Day05.part1_strategy1(input)

    print("│  ├─ Strategy 02:")
    @btime Day05.part1_strategy2(input)

    print("│  └─ Strategy 03:")
    @btime Day05.part1_strategy3(input)

    # Part 2
    print("└─ Part 02:")
    @btime Day05.part2(input)
end


# Day 06 ----------------------------------------------------------------------

if day == 0 || day == 6
    inputpath = getinput("Day06", "input")
    input = Day06.ingest(inputpath)

    println("\nDay 06:")

    print("├─ Part 01:")
    @btime Day06.solve(input, 80)

    print("└─ Part 02:")
    @btime Day06.solve(input, 256)
end


# Day 07 ----------------------------------------------------------------------

if day == 0 || day == 7
    inputpath = getinput("Day07", "input")
    input = Day07.ingest(inputpath)

    println("\nDay 07:")

    print("├─ Part 01:")
    @btime Day07.part1(input)

    print("└─ Part 02:")
    @btime Day07.part2(input)
end


# Day 08 ----------------------------------------------------------------------

if day == 0 || day == 8
    inputpath = getinput("Day08", "input")
    input = Day08.ingest(inputpath)

    println("\nDay 08:")

    print("├─ Part 01:")
    @btime Day08.part1(input)

    print("└─ Part 02:")
    @btime Day08.part2(input)
end


# Day 09 ----------------------------------------------------------------------

if day == 0 || day == 9
    inputpath = getinput("Day09", "input")
    input = Day09.ingest(inputpath)

    println("\nDay 09:")

    print("├─ Part 01:")
    @btime Day09.part1(input)

    print("└─ Part 02:")
    @btime Day09.part2(input)
end


# Day 10 ----------------------------------------------------------------------

if day == 0 || day == 10
    inputpath = getinput("Day10", "input")
    input = Day10.ingest(inputpath)

    println("\nDay 10:")

    print("├─ Part 01:")
    @btime Day10.part1(input)

    print("└─ Part 02:")
    @btime Day10.part2(input)
end


# Day 11 ----------------------------------------------------------------------

if day == 0 || day == 11
    inputpath = getinput("Day11", "input")
    input = Day11.ingest(inputpath)

    println("\nDay 11:")

    print("├─ Part 01:")
    @btime Day11.part1(input)

    print("└─ Part 02:")
    @btime Day11.part2(input)
end


# Day 13 ----------------------------------------------------------------------

if day == 0 || day == 13
    inputpath = getinput("Day13", "input")
    input = Day13.ingest(inputpath)

    println("\nDay 13:")

    print("├─ Part 01:")
    @btime Day13.part1(input)

    print("└─ Part 02:")
    @btime Day13.part2(input)
end


# Day 12 ----------------------------------------------------------------------

if day == 0 || day == 12
    inputpath = getinput("Day12", "input")
    input = Day12.ingest(inputpath)

    println("\nDay 12:")

    print("├─ Part 01:")
    @btime Day12.part1(input)

    print("└─ Part 02:")
    @btime Day12.part2(input)
end


# End -------------------------------------------------------------------------

println()