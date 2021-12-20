module JuliaAdventOfCode

inputdirpath = normpath(joinpath(@__FILE__,"..","..","inputs"))
getinput(d, fn) = joinpath(inputdirpath, d, "$fn.txt")
export getinput
export Day01, Day02, Day03, Day04, Day05, 
       Day06, Day07, Day08, Day09, Day10,
       Day11, Day12, Day13, Day14, Day15,
       Day16, Day17, Day18, Day19, Day20

# Include every test file in this folder
dayfilere = r"Day\d{2}/Day\d{2}.jl$"

for (root, dirs, files) in walkdir(@__DIR__)
    for file in files
        filepath = joinpath(root, file)
        if occursin(dayfilere, filepath)
            include(filepath)
        end
    end
end

end # module