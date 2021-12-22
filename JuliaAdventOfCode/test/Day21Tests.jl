using JuliaAdventOfCode: getinput, Day21

@testset "Day18 Tests" begin
    testinputpath = getinput("Day18", "test")
    testinput = Day18.ingest(testinputpath)
    @test Day18.part1(testinput) == 739_785
    @test Day18.part2(testinput) == 444_356_092_776_315

    realinputpath = getinput("Day18", "input")
    realinput = Day18.ingest(realinputpath)
    @test Day18.part1(realinput) == 512_442
    @test Day18.part2(realinput) == 346_642_902_541_848
end