using JuliaAdventOfCode: getinput, Day08

@testset "Day08 Tests" begin
    testinputpath = getinput("Day08", "test")
    testinput = Day08.ingest(testinputpath)
    @test Day08.part1(testinput) == 26
    @test Day08.part2(testinput) == 61_229

    realinputpath = getinput("Day08", "input")
    realinput = Day08.ingest(realinputpath)
    @test Day08.part1(realinput) == 512
    @test Day08.part2(realinput) == 1_091_165
end