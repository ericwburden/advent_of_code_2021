using JuliaAdventOfCode: getinput, Day02

@testset "Day02 Tests" begin
    testinputpath = getinput("Day02", "test")
    testinput = Day02.ingest(testinputpath)
    part1_test_answer = 150
    part2_test_answer = 900
    @test Day02.part1_strategy1(testinput) == part1_test_answer
    @test Day02.part1_strategy2(testinput) == part1_test_answer
    @test Day02.part1_strategy3(testinput) == part1_test_answer
    @test Day02.part2_strategy1(testinput) == part2_test_answer
    @test Day02.part2_strategy2(testinput) == part2_test_answer
    @test Day02.part2_strategy3(testinput) == part2_test_answer

    realinputpath = getinput("Day02", "input")
    realinput = Day02.ingest(realinputpath)
    part1_real_answer = 1_804_520
    part2_real_answer = 1_971_095_320
    @test Day02.part1_strategy1(realinput) == part1_real_answer
    @test Day02.part1_strategy2(realinput) == part1_real_answer
    @test Day02.part1_strategy3(realinput) == part1_real_answer
    @test Day02.part2_strategy1(realinput) == part2_real_answer
    @test Day02.part2_strategy2(realinput) == part2_real_answer
    @test Day02.part2_strategy3(realinput) == part2_real_answer
end