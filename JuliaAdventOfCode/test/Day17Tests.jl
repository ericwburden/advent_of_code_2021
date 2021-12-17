using JuliaAdventOfCode: getinput, Day17

@testset "Day17 Tests" begin
    testinputpath = getinput("Day17", "test")
    testinput = Day17.ingest(testinputpath)
    @test Day17.part1(testinput) == 45
    @test Day17.part2(testinput) == 112

    realinputpath = getinput("Day17", "input")
    realinput = Day17.ingest(realinputpath)
    @test Day17.part1(realinput) == 12_246
    @test Day17.part2(realinput) == 3_528
end