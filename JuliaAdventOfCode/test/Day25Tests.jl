using JuliaAdventOfCode: getinput, Day25

@testset "Day25 Tests" begin
    testinputpath = getinput("Day25", "test")
    testinput = Day25.ingest(testinputpath)
    @test Day25.part1(testinput) == 58

    realinputpath = getinput("Day25", "input")
    realinput = Day25.ingest(realinputpath)
    @test Day25.part1(realinput) == 367
end