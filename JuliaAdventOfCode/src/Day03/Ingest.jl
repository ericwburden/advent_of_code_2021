process(s::AbstractString)::Vector{Bool} = split(s, "") .== "1"

function ingest(path)
    input = open(path) do f
        # Get a Vector of Boolean vectors, convert to a BitMatrix,
        # then transpose it such that the first column contains the 
        # first bit of every number, the second column contains the
        # second bit, etc.
        bitvecs = [process(s) for s in readlines(f)]
        bitmatrix = reduce(hcat, bitvecs)
        transpose(bitmatrix)
    end
end
