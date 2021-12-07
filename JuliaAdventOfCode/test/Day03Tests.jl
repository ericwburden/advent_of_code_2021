using JuliaAdventOfCode: getinput, Day03

@testset "Day03 Tests" begin
    testinputpath = getinput("Day03", "test")
    testinput = Day03.ingest(testinputpath)
    @test Day03.part1(testinput) == 198
    @test Day03.part2(testinput) == 230

    realinputpath = getinput("Day03", "input")
    realinput = Day03.ingest(realinputpath)
    @test Day03.part1(realinput) == 775_304
    @test Day03.part2(realinput) == 1_370_737
end