using JuliaAdventOfCode: getinput, Day06

@testset "Day06 Tests" begin
    testinputpath = getinput("Day06", "test")
    testinput = Day06.ingest(testinputpath)
    @test Day06.solve(testinput,  18) == 26
    @test Day06.solve(testinput,  80) == 5_934
    @test Day06.solve(testinput, 256) == 26_984_457_539

    realinputpath = getinput("Day06", "input")
    realinput = Day06.ingest(realinputpath)
    @test Day06.solve(realinput,  80) == 346_063
    @test Day06.solve(realinput, 256) == 1_572_358_335_990
end