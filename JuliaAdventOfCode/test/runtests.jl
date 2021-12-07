using Test

# Include every test file in this folder
testfilere = r"^Day0\dTests.jl$"

for filename in readdir(@__DIR__)
    if occursin(testfilere, filename)
        include(filename)
    end
end
