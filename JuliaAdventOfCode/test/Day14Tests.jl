using JuliaAdventOfCode: getinput, Day14

@testset "Day14 Tests" begin
    testinputpath = getinput("Day14", "test")
    testinput = Day14.ingest(testinputpath)
    @test Day14.part1(testinput) == 1_588
    @test Day14.part2(testinput) == 2_188_189_693_529

    realinputpath = getinput("Day14", "input")
    realinput = Day14.ingest(realinputpath)
    @test Day14.part1(realinput) == 2_745
    @test Day14.part2(realinput) == 3_420_801_168_962
end