using JuliaAdventOfCode: getinput, Day20

@testset "Day20 Tests" begin
    testinputpath = getinput("Day20", "test")
    testinput = Day20.ingest(testinputpath)
    @test Day20.solve(testinput, 2; test = true) == 35
    @test Day20.solve(testinput, 50, test = true) == 3_351

    realinputpath = getinput("Day20", "input")
    realinput = Day20.ingest(realinputpath)
    @test Day20.solve(realinput, 2) == 5_437
    @test Day20.solve(realinput, 50) == 19_340
end