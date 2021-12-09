using JuliaAdventOfCode: getinput, Day09

@testset "Day09 Tests" begin
    testinputpath = getinput("Day09", "test")
    testinput = Day09.ingest(testinputpath)
    @test Day09.part1(testinput) == 15
    @test Day09.part2(testinput) == 1_134

    realinputpath = getinput("Day09", "input")
    realinput = Day09.ingest(realinputpath)
    @test Day09.part1(realinput) == 456
    @test Day09.part2(realinput) ==  1_047_744
end