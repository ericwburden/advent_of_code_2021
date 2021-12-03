# Given a Matrix as `input` and a `discriminator` function, repeatedly
# evaluate columns of `input` from left to right, keeping only rows where 
# `discriminator` is satisfied. Repeat until only one row remains and 
# return that row as a BitVector
function find_first_match(input, discriminator)
    mask = trues(size(input, 1))
    for col in eachcol(input)
        common_value = discriminator(col[mask])

        # Carry forward only mask indices where the common value
        # is found in each column
        mask = mask .& (col .== common_value)

        # Stop looking if mask contains only one `true`. 
        sum(mask) == 1 && break
    end

    # Convert n x 1 BitMatrix to BitVector
    (input[mask,:]
        |> Iterators.flatten
        |> BitVector)
end

# Dispatch to `find_first_match` with different `discriminator`s
find_oxygen_generator_rating(x) = find_first_match(x, mostcommon)
find_co2_scrubber_rating(x)     = find_first_match(x, !mostcommon)

function part2(input)
    oxygen_generator_rating = find_oxygen_generator_rating(input)
    co2_scrubber_rating = find_co2_scrubber_rating(input)
    convert(Int, oxygen_generator_rating) * convert(Int, co2_scrubber_rating)
end