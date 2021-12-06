using BenchmarkTools
using ArgParse


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

srcpath = normpath(joinpath(@__FILE__,"..","..","src"))

println("\nJulia Advent of Code 2021 Benchmarks:")


# Day 01 ----------------------------------------------------------------------

if day == 0 || day == 1
    include("$srcpath/Day01/Day01.jl")
    println("\nDay 01:")

    print("├─ Part 01:")
    @btime Day01.part1(Day01.input)

    print("└─ Part 02:")
    @btime Day01.part2(Day01.input)
end


# Day 02 ----------------------------------------------------------------------

if day == 0 || day == 2
    include("$srcpath/Day02/Day02.jl")
    println("\nDay 02:")

    # Part 1
    println("├─ Part 01:")

    print("│  ├─ Strategy 01:")
    @btime Day02.part1_strategy1(Day02.input)

    print("│  ├─ Strategy 02:")
    @btime Day02.part1_strategy2(Day02.input)

    print("│  └─ Strategy 03:")
    @btime Day02.part1_strategy3(Day02.input)

    # Part 2
    println("└─ Part 02:")

    print("   ├─ Strategy 01:")
    @btime Day02.part2_strategy1(Day02.input)

    print("   ├─ Strategy 02:")
    @btime Day02.part2_strategy2(Day02.input)

    print("   └─ Strategy 03:")
    @btime Day02.part2_strategy3(Day02.input)
end


# Day 03 ----------------------------------------------------------------------

if day == 0 || day == 3
    include("$srcpath/Day03/Day03.jl")
    println("\nDay 03:")

    print("├─ Part 01:")
    @btime Day03.part1(Day03.input)

    print("└─ Part 02:")
    @btime Day03.part2(Day03.input)
end


# Day 04 ----------------------------------------------------------------------

if day == 0 || day == 4
    include("$srcpath/Day04/Day04.jl")
    println("\nDay 04:")

    print("├─ Part 01:")
    boardscopy = deepcopy(Day04.boards)
    @btime Day04.part1(Day04.numbers, boardscopy)

    print("└─ Part 02:")
    @btime Day04.part2(Day04.numbers, Day04.boards)
end


# Day 05 ----------------------------------------------------------------------

if day == 0 || day == 5
    include("$srcpath/Day05/Day05.jl")
    println("\nDay 05:")

    print("├─ Part 01:")
    @btime Day05.part1(Day05.input)

    print("└─ Part 02:")
    @btime Day05.part2(Day05.input)
end


# End -------------------------------------------------------------------------

println()