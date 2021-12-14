# Useful Data Structures ------------------------------------------------------

# Type alias for the `pairmap` generated in our input parser
const PairMap    = Dict{String,NTuple{2,String}}

# Ingest the Data -------------------------------------------------------------

# Read and parse the first line into a vector of element pairs, such that "HNH"
# will yield a `template` of ["HN", "NH"].
# Read and parse the remaining lines into a `PairMap` , coercing a line "CH -> B"
# in the input into a "CH" => ["CB", "BH"] entry in the `PairMap`.
function ingest(path)
    return open(path) do f
        # Parse the first line
        templatestr = readuntil(f, "\n\n")
        len = length(templatestr)
        template = map(i -> templatestr[i:i+1], 1:len-1)

        # Parse the remaining lines
        pairmap = Dict{String,NTuple{2,String}}()
        for pairstr in readlines(f)
            (pair, insert) = split(pairstr, " -> ")
            newpairs = (pair[1] * insert, insert * pair[2])
            pairmap[pair] = newpairs
        end

        # Return a tuple of the template and pairmap
        (template, pairmap)
    end
end

