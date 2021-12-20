# Some Useful Data Structures --------------------------------------------------

# Used to get the coordinates of the nine pixels surrounding any given
# pixel in the image
const OFFSETS = [(-1,-1), (-1,0), (-1,1), (0,-1), (0,0), (0,1), (1,-1), (1,0), (1,1)]


# Helper Functions -------------------------------------------------------------

# Get a list of the coordinates of the pixels surrounding a given point
offsets(p::Point) = [p .+ offset for offset in OFFSETS]

# Convert binary value to decimal
todecimal(x) = sum(D*2^(P-1) for (D, P) in zip(x, length(x):-1:1))

# Given a point in the image, calculate the value of the point from the
# 3x3 area centered on that point
function valueat(image::Image, point::Point, default=false)
    value = [get(image, p, default) for p in offsets(point)]
    return todecimal(value)
end

# Enhance the image! Creates a new image (expanded by one in all directions) 
# where each pixel is flipped according to its calculated value.
function enhance(image::Image, algo::BitVector, default=false)
    newimage = Dict{Point,Bool}()

    # Need to expand the enhancement area by 1 in all directions each pass
    (minpoint, maxpoint) = extrema(keys(image))
    rng = (minpoint[1]-1):(maxpoint[2]+1)

    # For each possible point in the new image, determine its value
    for point in Iterators.product(rng, rng)
        pointvalue = valueat(image, point, default)
        pixel = algo[pointvalue + 1]
        newimage[point] = pixel
    end

    return newimage
end

# Solve ------------------------------------------------------------------------

function solve(input, rounds; test = false)
    (algo, image) = input
    for round in 1:rounds
        # The 'real' algorithm (not the test) has a '#' in the first position 
        # and a '.' in the last position, which means that the 'empty' pixels
        # surrounding the image all flip from '.' to '#' on odd numbered rounds.
        # The 'test' input does not have this 'feature'.
        default = !test && round % 2 == 0
        image = enhance(image, algo, default)
    end
    return sum(values(image))
end