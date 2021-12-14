# Solve Part Two ---------------------------------------------------------------

# Exactly the same as Part One, just get the 40th generated Polymer
function part2(input)
    polymergenerator = PolymerGenerator(input...)
    elementcount = countelements(polymergenerator[40])
    (least, most) = extrema(values(elementcount))
    return most - least
end