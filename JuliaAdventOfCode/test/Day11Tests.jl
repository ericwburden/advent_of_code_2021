using JuliaAdventOfCode: getinput, Day11

@testset "Day11 Tests" begin
    testinputpath = getinput("Day11", "test")
    testinput = Day11.ingest(testinputpath)
    @test Day11.part1(testinput) == 1_656
    @test Day11.part2(testinput) == 195

    realinputpath = getinput("Day11", "input")
    realinput = Day11.ingest(realinputpath)
    @test Day11.part1(realinput) == 1_691
    @test Day11.part2(realinput) == 216
end