using JuliaAdventOfCode: getinput, Day19

@testset "Day19 Tests" begin
    testinputpath = getinput("Day19", "test")
    testinput = Day19.ingest(testinputpath)
    (mapped, offsets) = Day19.mapscanners(testinput)
    @test Day19.part1(mapped) == 79
    @test Day19.part2(offsets) == 3621

    realinputpath = getinput("Day19", "input")
    realinput = Day19.ingest(realinputpath)
    (mapped, offsets) = Day19.mapscanners(realinput)
    @test Day19.part1(mapped) == 392
    @test Day19.part2(offsets) == 13_332
end