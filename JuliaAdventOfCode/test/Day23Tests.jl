using JuliaAdventOfCode: getinput, Day23

@testset "Day23 Tests" begin
    testinputpath = getinput("Day23", "test")

    testinput1 = Day23.Part1.ingest(testinputpath)
    @test Day23.Part1.part1(testinput1) == 12_521

    testinput2 = Day23.Part2.ingest(testinputpath)
    @test Day23.Part2.part2(testinput2) == 44_169


    realinputpath = getinput("Day23", "input")
    
    realinput1 = Day23.Part1.ingest(realinputpath)
    @test Day23.Part1.part1(realinput1) == 17_120
    
    realinput2 = Day23.Part2.ingest(realinputpath)
    @test Day23.Part2.part2(realinput2) == 47_234
end