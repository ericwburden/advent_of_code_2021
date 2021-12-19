using JuliaAdventOfCode: getinput, Day18

@testset "Day18 Tests" begin
    testinputpath = getinput("Day18", "test")
    testinput = Day18.ingest(testinputpath)
    @test Day18.part1(testinput) == 4140
    @test Day18.part2(testinput) == 3993

    realinputpath = getinput("Day18", "input")
    realinput = Day18.ingest(realinputpath)
    @test Day18.part1(realinput) == 4184
    @test Day18.part2(realinput) == 4731
end