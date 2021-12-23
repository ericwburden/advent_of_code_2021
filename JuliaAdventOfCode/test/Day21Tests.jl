using JuliaAdventOfCode: getinput, Day21

@testset "Day21 Tests" begin
    testinputpath = getinput("Day21", "test")
    testinput = Day21.ingest(testinputpath)
    @test Day21.part1(testinput) == 739_785
    @test Day21.part2(testinput) == 444_356_092_776_315

    realinputpath = getinput("Day21", "input")
    realinput = Day21.ingest(realinputpath)
    @test Day21.part1(realinput) == 512_442
    @test Day21.part2(realinput) == 346_642_902_541_848
end