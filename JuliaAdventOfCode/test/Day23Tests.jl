using JuliaAdventOfCode: getinput, Day23

@testset "Day23 Tests" begin
    @test Day23.Part1.part1(true) == 12_521
    @test Day23.Part2.part2(true) == 44_169

    @test Day23.Part1.part1(false) == 17_120
    @test Day23.Part2.part2(false) == 47_234
end