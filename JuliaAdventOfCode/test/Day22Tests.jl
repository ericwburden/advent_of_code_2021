using JuliaAdventOfCode: getinput, Day22

@testset "Day22 Tests" begin
    testinputpath = getinput("Day22", "test1")
    testinput = Day22.ingest(testinputpath)
    @test Day22.part1(testinput) == 590_784

    testinputpath = getinput("Day22", "test2")
    testinput = Day22.ingest(testinputpath)
    @test Day22.part2(testinput) == 2_758_514_936_282_235

    realinputpath = getinput("Day22", "input")
    realinput = Day22.ingest(realinputpath)
    @test Day22.part1(realinput) == 652_209
    @test Day22.part2(realinput) == 1_217_808_640_648_260
end