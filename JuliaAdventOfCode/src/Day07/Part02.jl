using Base.Iterators
using Statistics 

# Overloading arbitrary operators is fun!
±(a, b) = (a + b, a - b)

# Use the Gaussian method for summing sequences of numbers to quickly calculate
# the total distance of all crabs to a given position.
function gaussdistance(position::Int, crabs::Vector{Int})::Int
    # So much broadcasting!
    n = abs.(crabs .- position) .+ 1
    distances = (n .* (n .- 1)) .÷ 2
    return sum(distances)
end

# Makes a reasonable guess about where the optimal crab position is, then
# searches to the left or right to find the real optimal position.
function part2(input)
    # Start at a reasonable place, the average value of the crab positions
    startingat = trunc(Int, mean(input))
    crabdistance(x) = gaussdistance(x, input)
    currentmin = crabdistance(startingat)

    # Now we need to decide if we should search for a position to the left
    # or right of our starting position. Check to the left and right of the
    # starting position. We'll move in whichever direction has a lower
    # aggregate crab distance. If somehow our guess was spot on, we'll 
    # end up skipping the for loop below and just returning the total distance
    # to the starting position.
    (left, right) = startingat ± 1
    (leftdist, rightdist) = map(crabdistance, (left, right))
    
    (position, nextdist, step) = (
        leftdist < rightdist 
        ? (left, leftdist, -1) 
        : (right, rightdist, 1)
    )

    # Now just iterate in the direction we decided on above, until we find
    # the total distance starts to increase. At that point, we can return 
    # the minimum value found.
    while nextdist < currentmin
        currentmin = nextdist
        position += step
        nextdist = crabdistance(position)
    end
    return currentmin
end