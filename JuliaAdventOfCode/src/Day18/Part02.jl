# Solve Part Two ===============================================================

# Add each pair of snailfish numbers, forwards and backwards, and report the
# largest magnitude of a sum that we can find.
function part2(input)
    input = deepcopy(input)
    maxmagnitude = 0

    # For each unique pair of numbers (each of which is represented by a `Tree`)
    for (a, b) in Iterators.product(input, input)
        # Add `b` to `a` to make a new tree
        template = combine(a, b)

        # Copy that tree, simplify it, then check its magnitude
        tree1 = deepcopy(template)
        simplify!(tree1)
        mag1 = magnitude(tree1)

        # 'Flip' the `template` tree, copy it, simplify, then check the 
        # magnitude again.
        (template.root.left, template.root.right) = (template.root.right, template.root.left)
        tree2 = deepcopy(template)
        simplify!(tree2)
        mag2 = magnitude(tree2)

        # If either magnitude is larger than the largest found so far, it
        # becomes the new largest
        maxmagnitude = max(maxmagnitude, mag1, mag2)
    end
    return maxmagnitude
end