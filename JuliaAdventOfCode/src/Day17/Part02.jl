# Multiple Dispatch! -----------------------------------------------------------

# Solve Part Two ---------------------------------------------------------------

# This time, just search through the whole range of possible x/y combinations
# and increment the counter for each launch velocity that lands the probe in
# the target area.
function part2(input)
    v_range = velocityrange(input)
    found = 0

    for (v_x, v_y) in Iterators.product(v_range...)
        initial = (x=v_x, y=v_y)
        if willhit(initial, input)
            found += 1
        end
    end

    return found
end