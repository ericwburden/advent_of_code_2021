using JuliaAdventOfCode: getinput, Day10

@testset "Day10 Tests" begin
    testinputpath = getinput("Day10", "test")
    testinput = Day10.ingest(testinputpath)
    @test Day10.part1(testinput) == 26_397
    @test Day10.part2(testinput) == 288_957

    realinputpath = getinput("Day10", "input")
    realinput = Day10.ingest(realinputpath)
    @test Day10.part1(realinput) == 290_691
    @test Day10.part2(realinput) == 2_768_166_558
end