using JuliaAdventOfCode: getinput, Day13

@testset "Day13 Tests" begin
    testinputpath = getinput("Day13", "test")
    testinput = Day13.ingest(testinputpath)
    @test Day13.part1(testinput) == 17
    @test Day13.part2(testinput) == ([5, 2, 2, 2, 5, 0, 0], [5, 2, 2, 2, 5])

    realinputpath = getinput("Day13", "input")
    realinput = Day13.ingest(realinputpath)
    @test Day13.part1(realinput) == 675
    @test Day13.part2(realinput) == (
        [24, 11, 19, 11, 12, 21], 
        [6, 1, 1, 6, 0, 3, 3, 3, 3, 0, 6, 1, 3, 2, 0, 6, 1, 1, 6, 0, 6, 2, 2, 1, 0, 6, 3, 3, 2, 0, 1, 1, 2, 5, 0, 3, 3, 3, 3, 0]
    )
end