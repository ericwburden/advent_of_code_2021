# Some Useful Data Structures --------------------------------------------------

# Type alias for keeping up with the count of pairs in our `Polymer`. Instead
# of keeping track of the full sequence of elements in order, we only need
# the counts. By keeping a dictionary of each element pair and their counts,
# we make each step of the analysis run in constant time and space.
const PairCounts = Dict{String,Int}

# A `Polymer` is really just a wrapper around a `PairCounts`
struct Polymer
    paircounts::PairCounts
end


# Setup for Iterating Polymers -------------------------------------------------

# The iterator struct, holds the template and pairmap. The template is needed
# for the first iteration, and the pairmap is used to generate the subsequent
# `PairCounts` objects.
struct PolymerGenerator
    template::Vector{String}
    pairmap::PairMap
end

# First iteration, performs the first insertion and returns a `Polymer` 
# representing the result. Note, again, we're not actually
# inserting letters into a string, just keeping up with a count of letter 
# pairs. This means that, assuming a `PairMap` of {"CH" => ["CB", "BH"]}
# and a `PairCounts`  of {"CH" => 1}, the resulting `PairCounts` will contain
# {"CH" => 0, "CB" => 1, "BH" => 1}.
function Base.iterate(pg::PolymerGenerator)
    paircounts = Dict([(pair, 0) for pair in keys(pg.pairmap)])
    for pair in pg.template
        (first, second) = pg.pairmap[pair]
        paircounts[first]  += 1
        paircounts[second] += 1
    end
    return (Polymer(paircounts), paircounts)
end

# Subsequent iterations, given a `PairCounts` as the state, performs another
# insertion operation and returns the result.
function Base.iterate(pg::PolymerGenerator, paircounts::PairCounts)
    newpaircounts = Dict([(pair, 0) for pair in keys(pg.pairmap)])
    for (pair, count) in paircounts
        (first, second) = pg.pairmap[pair]
        newpaircounts[first]  += count
        newpaircounts[second] += count
    end
    return (Polymer(newpaircounts), newpaircounts)
    
end

# Iterate the `PolymerGenerator` `i` times and return the result
function Base.getindex(pg::PolymerGenerator, i::Int)
    for (iteration, polymer) in enumerate(pg)
        iteration >= i && return polymer
    end
end

# Count the number of elements in the given `Polymer`. Now, since we're keeping up
# with letter pairs instead of the actual string, we need to do a tiny bit of
# math. For example, the string "NNCB" would be represented by a `PairCounts` of 
# {"NN" => 1, "NC" => 1, "CB" => 1}, and would yield a `lettercounts` below of 
# {'N' => 3, 'C' => 2, 'B' => 1}. For letters in the middle, we can get the 
# actual element count as `lettercounts['C'] / 2`. Since letters at the end 
# aren't being counted twice like letters in the middle, just round up the 
# result of `lettercounts['N'] / 2` to get the number of 'N's in the string "NNCB"
function countelements(polymer::Polymer)
    lettercounts = Dict{Char,Int}()
    for (pair, count) in polymer.paircounts
        for letter in pair
            if letter ∉ keys(lettercounts)
                lettercounts[letter] = count
            else
                lettercounts[letter] += count
            end
        end
    end

    elementcounts = Dict{Char,Int}()
    for (letter, count) in lettercounts
        elementcounts[letter] = ceil(count/2)
    end

    return elementcounts
end


# Solve Part One ---------------------------------------------------------------

# With all that setup, this part is easy. Create a `PolymerGenerator` from the 
# input, get the 10th generated polymer, take the minumum and maximum element
# counts, and return the difference.
function part1(input)
    polymergenerator = PolymerGenerator(input...)
    elementcount = countelements(polymergenerator[10])
    (least, most) = extrema(values(elementcount))
    return most - least
end