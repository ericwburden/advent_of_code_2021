using JuliaAdventOfCode: getinput, Day24

@testset "Day24 Tests" begin
    (answer1, answer2) = Day24.solve()

    @test Day24.isvalid(answer1)
    @test !Day24.isvalid(answer1 - 1)
    @test !Day24.isvalid(answer1 + 1)

    @test Day24.isvalid(answer2)
    @test !Day24.isvalid(answer2 - 1)
    @test !Day24.isvalid(answer2 + 1)
end