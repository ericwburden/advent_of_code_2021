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


# Day 14 ----------------------------------------------------------------------

if day == 0 || day == 14
    inputpath = getinput("Day14", "input")
    input = Day14.ingest(inputpath)

    println("\nDay 14:")

    print("├─ Part 01:")
    @btime Day14.part1(input)

    print("└─ Part 02:")
    @btime Day14.part2(input)
end


# Day 15 ----------------------------------------------------------------------

if day == 0 || day == 15
    inputpath = getinput("Day15", "input")
    input = Day15.ingest(inputpath)

    println("\nDay 15:")

    print("├─ Part 01:")
    @btime Day15.part1(input)

    print("└─ Part 02:")
    @btime Day15.part2(input)
end


# Day 16 ----------------------------------------------------------------------

if day == 0 || day == 16
    inputpath = getinput("Day16", "input")
    input = Day16.ingest(inputpath)

    println("\nDay 16:")

    print("├─ Part 01:")
    @btime Day16.part1(input)

    print("└─ Part 02:")
    @btime Day16.part2(input)
end


# Day 17 ----------------------------------------------------------------------

if day == 0 || day == 17
    inputpath = getinput("Day17", "input")
    input = Day17.ingest(inputpath)

    println("\nDay 17:")

    print("├─ Part 01:")
    @btime Day17.part1(input)

    print("└─ Part 02:")
    @btime Day17.part2(input)
end


# Day 18 ----------------------------------------------------------------------

if day == 0 || day == 18
    inputpath = getinput("Day18", "input")
    input = Day18.ingest(inputpath)

    println("\nDay 18:")

    print("├─ Part 01:")
    @btime Day18.part1(input)

    print("└─ Part 02:")
    @btime Day18.part2(input)
end


# Day 19 ----------------------------------------------------------------------

if day == 0 || day == 19
    inputpath = getinput("Day19", "input")
    input = Day19.ingest(inputpath)

    println("\nDay 19:")

    print("├─ Building Input:")
    (mapped, offsets) = @btime Day19.mapscanners(input)

    print("├─ Part 01:")
    @btime Day19.part1(mapped)

    print("└─ Part 02:")
    @btime Day19.part2(offsets)
end


# Day 20 ----------------------------------------------------------------------

if day == 0 || day == 20
    inputpath = getinput("Day20", "input")
    input = Day20.ingest(inputpath)

    println("\nDay 20:")

    print("├─ Part 01:")
    @btime Day20.solve(input, 2)

    print("└─ Part 02:")
    @btime Day20.solve(input, 50)
end


# Day 21 ----------------------------------------------------------------------

if day == 0 || day == 21
    inputpath = getinput("Day21", "input")
    input = Day21.ingest(inputpath)

    println("\nDay 21:")

    print("├─ Part 01:")
    @btime Day21.part1(input)

    print("└─ Part 02:")
    @btime Day21.part2(input)
end


# Day 22 ----------------------------------------------------------------------

if day == 0 || day == 22
    inputpath = getinput("Day22", "input")
    input = Day22.ingest(inputpath)

    println("\nDay 22:")

    print("├─ Part 01:")
    @btime Day22.part1(input)

    print("└─ Part 02:")
    @btime Day22.part2(input)
end


# Day 23 ----------------------------------------------------------------------

if day == 0 || day == 23

    println("\nDay 23:")

    print("├─ Part 01:")
    @btime Day23.Part1.part1()

    print("└─ Part 02:")
    @btime Day23.Part2.part2()
end


# Day 24 ----------------------------------------------------------------------

if day == 0 || day == 24
    (answer1, answer2) = Day24.solve()

    println("\nDay 24:")

    print("├─ Benchmarking answer confirmation...")

    print("├─ Part 01:")
    @btime Day24.isvalid(answer1)

    print("└─ Part 02:")
    @btime Day24.isvalid(answer2)
end


# Day 25 ----------------------------------------------------------------------

if day == 0 || day == 25
    inputpath = getinput("Day25", "input")
    input = Day25.ingest(inputpath)

    println("\nDay 25:")

    print("└─ Part 01:")
    @btime Day25.part1(input)
end


# End -------------------------------------------------------------------------

println()