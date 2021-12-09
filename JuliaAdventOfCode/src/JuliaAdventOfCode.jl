module JuliaAdventOfCode

inputdirpath = normpath(joinpath(@__FILE__,"..","..","inputs"))
getinput(d, fn) = joinpath(inputdirpath, d, "$fn.txt")
export getinput
export Day01, Day02, Day03, Day04, Day05, 
       Day06, Day07, Day08, Day09

# Include every test file in this folder
dayfilere = r"Day0\d/Day0\d.jl$"

for (root, dirs, files) in walkdir(@__DIR__)
    for file in files
        filepath = joinpath(root, file)
        if occursin(dayfilere, filepath)
            include(filepath)
        end
    end
end

end # module