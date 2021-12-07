using JuliaAdventOfCode: getinput, Day04

@testset "Day04 Tests" begin
    testinputpath = getinput("Day04", "test")
    (test_numbers, test_boards) = Day04.ingest(testinputpath)
    @test Day04.part1(test_numbers, deepcopy(test_boards)) == 4512
    @test Day04.part2(test_numbers, deepcopy(test_boards)) == 1924

    realinputpath = getinput("Day04", "input")
    (real_numbers, real_boards) = Day04.ingest(realinputpath)
    @test Day04.part1(real_numbers, deepcopy(real_boards)) == 14093
    @test Day04.part2(real_numbers, deepcopy(real_boards)) == 17388
end