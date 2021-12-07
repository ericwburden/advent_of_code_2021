using JuliaAdventOfCode: getinput, Day05

@testset "Day05 Tests" begin
    testinputpath = getinput("Day05", "test")
    testinput = Day05.ingest(testinputpath)
    part1_test_answer = 5
    @test Day05.part1_strategy1(testinput) == part1_test_answer
    @test Day05.part1_strategy2(testinput) == part1_test_answer
    @test Day05.part1_strategy3(testinput) == part1_test_answer
    @test Day05.part2(testinput) == 12

    realinputpath = getinput("Day05", "input")
    realinput = Day05.ingest(realinputpath)
    part1_real_answer = 7_414
    @test Day05.part1_strategy1(realinput) == part1_real_answer
    @test Day05.part1_strategy2(realinput) == part1_real_answer
    @test Day05.part1_strategy3(realinput) == part1_real_answer
    @test Day05.part2(realinput) == 19_676
end