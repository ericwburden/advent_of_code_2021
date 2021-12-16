using JuliaAdventOfCode: getinput, Day15

@testset "Day15 Tests" begin
    testinputpath = getinput("Day15", "test")
    testinput = Day15.ingest(testinputpath)
    @test Day15.part1(testinput) == 40
    @test Day15.part2(testinput) == 315

    realinputpath = getinput("Day15", "input")
    realinput = Day15.ingest(realinputpath)
    @test Day15.part1(realinput) == 423
    @test Day15.part2(realinput) == 2_778
end