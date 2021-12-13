using JuliaAdventOfCode: getinput, Day12

@testset "Day12 Tests" begin
    testinputpath = getinput("Day12", "test")
    testinput = Day12.ingest(testinputpath)
    @test Day12.part1(testinput) == 10
    @test Day12.part2(testinput) == 36

    testinputpath = getinput("Day12", "test2")
    testinput = Day12.ingest(testinputpath)
    @test Day12.part1(testinput) == 19
    @test Day12.part2(testinput) == 103

    testinputpath = getinput("Day12", "test3")
    testinput = Day12.ingest(testinputpath)
    @test Day12.part1(testinput) == 226
    @test Day12.part2(testinput) == 3_509

    realinputpath = getinput("Day12", "input")
    realinput = Day12.ingest(realinputpath)
    @test Day12.part1(realinput) == 4_411
    @test Day12.part2(realinput) == 136_767
end