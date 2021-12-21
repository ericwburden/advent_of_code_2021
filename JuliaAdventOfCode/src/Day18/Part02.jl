# Solve Part Two ===============================================================

function part2(input)
    input = deepcopy(input)
    maxmagnitude = 0
    for (a, b) in Iterators.product(input, input)
        template = combine(a, b)

        tree1 = deepcopy(template)
        simplify!(tree1)
        mag1 = magnitude(tree1)

        (template.root.left, template.root.right) = (template.root.right, template.root.left)
        tree2 = deepcopy(template)
        simplify!(tree2)
        mag2 = magnitude(tree2)

        maxmagnitude = max(maxmagnitude, mag1, mag2)
    end
    return maxmagnitude
end