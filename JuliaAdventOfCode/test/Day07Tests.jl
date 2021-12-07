using JuliaAdventOfCode: getinput, Day07

@testset "Day07 Tests" begin
    testinputpath = getinput("Day07", "test")
    testinput = Day07.ingest(testinputpath)
    @test Day07.part1(testinput) == 37
    @test Day07.part2(testinput) == 168

    realinputpath = getinput("Day07", "input")
    realinput = Day07.ingest(realinputpath)
    @test Day07.part1(realinput) == 328_262
    @test Day07.part2(realinput) == 90_040_997
end