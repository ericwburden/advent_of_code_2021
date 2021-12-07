using JuliaAdventOfCode: getinput, Day01

@testset "Day01 Tests" begin
    testinputpath = getinput("Day01", "test")
    testinput = Day01.ingest(testinputpath)
    @test Day01.part1(testinput) == 7
    @test Day01.part2(testinput) == 5

    realinputpath = getinput("Day01", "input")
    realinput = Day01.ingest(realinputpath)
    @test Day01.part1(realinput) == 1583
    @test Day01.part2(realinput) == 1627
end