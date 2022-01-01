# Helper Functions -------------------------------------------------------------

# Check whether two cubes overlap
function overlap(a::Cube, b::Cube)
    (ax1, ax2, ay1, ay2, az1, az2) = bounds(a)
    (bx1, bx2, by1, by2, bz1, bz2) = bounds(b)
    return (   ax1 <= bx2 && ax2 >= bx1
            && ay1 <= by2 && ay2 >= by1
            && az1 <= bz2 && az2 >= bz1)
end

# Check whether the `Cube`s from two `Instruction`s overlap
overlap(a::Instruction, b::Instruction) = overlap(a.cube, b.cube)

# Mostly just used for sanity checking while developing the `shatter()` function
# below, but it's interesting enought to keep around. Returns a `Cube` 
# representing the portions of `a` and `b` that overlap.
function Base.intersect(a::Cube, b::Cube)
    overlap(a, b) || return Cube(0:0, 0:0, 0:0)
    (ax1, ax2, ay1, ay2, az1, az2) = bounds(a)
    (bx1, bx2, by1, by2, bz1, bz2) = bounds(b)
    x = max(ax1, bx1):min(ax2, bx2)
    y = max(ay1, by1):min(ay2, by2)
    z = max(az1, bz1):min(az2, bz2)
    return Cube(x, y, z)
end

# Volume of a cube. Tricky, right? Yeah, well, *I* mistakenly corrected for 
# Julia's 1-indexing by adding one to each of these lengths and spent _way_
# too long debugging the wrong thing before I realized what I'd done...
function volume(cube::Cube)
    xlen = length(cube.x)
    ylen = length(cube.y)
    zlen = length(cube.z)
    return xlen * ylen * zlen
end


# The next set of functions are related to functionality to break apart one
# `Cube` around another `Cube`. This depends on creating new `Cubes` for each
# "zone" around the smaller `Cube`, 8 zones that align with the corners of the
# smaller `Cube`, 6 zones that align with the faces of the smaller `Cube`, and
# 12 zones that align with the edges of the smaller `Cube`. This way, if an 
# 'off' `Instruction` has a cube that overlaps a `Cube` of lignts already on,
# we can 'cut out' the `Cube` that gets turned off from the `Cube` that's 
# already on, replacing the remaining portions of the 'on' `Cube` with smaller
# `Cube`s and removing the overlapping section.

# For "face" and "edge" zones, for each dimension, there are four possible
# ranges that can be taken based on the relative coordinates of the `target`
# and `template`. Arguments are the min/max coordinates of `target` and 
# `template` (from `shatter()`) in a single dimension. I find it easier to
# imagine these values as line endpoints on a number line, if one line
# stretches from D1>D2 and the other from d1>d2.
function middlerange(D1, D2, d1, d2)
    D1 <= d1 && D2 >= d2 && return d1:d2
    D1 > d1  && D2 >= d2 && return D1:d2
    D1 <= d1 && D2 < d2  && return d1:D2
    D1 > d1  && D2 < d2  && return D1:D2
    return nothing
end

# Break a `target` cube into up to 27 segments, based on the location of 
# template. I find it easiest to image that every corner of `template` that
# lies inside `target` emits a line in each direction, carving up `target`. 
# Returns all the pieces _except_ for the piece that intersects with the
# `template`.
function shatter(target::Cube, template::Cube)
    # I'm using capital letters for the `target`, and lowercase letters for
    # the `template` `Cube`.
    (X1, X2, Y1, Y2, Z1, Z2) = bounds(target)
    (x1, x2, y1, y2, z1, z2) = bounds(template)

    pieces = Vector{Cube}()

    # These checks are used to determine if any of the points of the `target`
    # cube stray into one of the 26 cubic 'zones' adjacent to the `template` 
    # cube. This includes 12 "edge" zones, 8 "corner" zones, and six "face"
    # zones.
    xoffsets = (X1 < x1, X1 <= x2 || x1 <= X2, x2 < X2)
    yoffsets = (Y1 < y1, Y1 <= y2 || y1 <= Y2, y2 < Y2)
    zoffsets = (Z1 < z1, Z1 <= z2 || z1 <= Z2, z2 < Z2)

    # The ranges to use to construct the pieces. For each axis: the range when 
    # the `target` extends past the `template` in the negative (xyz)-direction,
    # when the `target` occupies the same (xyz)-range as the `template`, and 
    # when the `target` extends past the `template` in the positive direction
    xranges = (X1:x1-1, middlerange(X1, X2, x1, x2), x2+1:X2)
    yranges = (Y1:y1-1, middlerange(Y1, Y2, y1, y2), y2+1:Y2)
    zranges = (Z1:z1-1, middlerange(Z1, Z2, z1, z2), z2+1:Z2)
    
    # Generate the pieces
    for (a, b, c) in Iterators.product(1:3, 1:3, 1:3)
        (a, b, c) == (2, 2, 2) && continue # Skip the `template` range
        if xoffsets[a] && yoffsets[b] && zoffsets[c]
            push!(pieces, Cube(xranges[a], yranges[b], zranges[c]))
        end
    end
    
    # Sanity check, ensures that the volume of the pieces returned + the volume
    # removed is equal to the volume of the `target` `Cube`. Not needed to run
    # the solution, but it was handy for debugging.
    # @assert sum(volume.(pieces)) + volume(intersect(template, target)) == volume(target)

    return pieces
end

# Convenience function to `shatter()` the cubes held by two `Instruction`s. 
# Returns a list of `Instruction`s containing each of the pieces.
function shatter(target::Instruction, template::Instruction)
    newcubes = shatter(target.cube, template.cube)
    return Instruction.(target.state, newcubes)
end

# Given an iterable containing `Instruction`s, add up the volume of all the
# `Instruction`s that turn lignts on.
function countlights(instructionset)
    lightson = 0
    for instruction in instructionset
        !instruction.state && continue
        lightson += volume(instruction.cube)
    end
    return lightson
end


# Solve Part Two ---------------------------------------------------------------

# Add each instruction to a set of final instructions. As each instruction is
# added, have it `shatter()` any `Instruction` it overlaps with before adding
# it to the set of final instructions, thereby replacing the overlapping
# region with itself. This means that instructions to turn lights off will 
# "overwrite" regions that turn lights on, and instructions that turn lights on
# dont' get double-counted.
function part2(input)
    finalinstructions = Set{Instruction}()
    for instrin in input
        for instrout in finalinstructions
            overlap(instrin, instrout) || continue # No overlaps? No problem!

            newinstrs = shatter(instrout, instrin)
            delete!(finalinstructions, instrout)

            # `shatter()` will return an empty list if `target` fits completely
            # inside `template`, so there's no parts of `target` to add back
            # after shattering in that case.
            isempty(newinstrs) && continue
            push!(finalinstructions, newinstrs...)
        end

        # Only need to store the 'on' `Instruction`s. 
        instrin.state && push!(finalinstructions, instrin)
    end

    return countlights(finalinstructions)
end
