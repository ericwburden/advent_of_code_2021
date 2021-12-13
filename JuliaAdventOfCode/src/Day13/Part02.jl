function prettyprint(matrix::BitMatrix)
    for line in eachrow(matrix)
        for bit in line
            if bit; print('█'); else; print(' '); end
        end
        println()
    end
end

function part2(input)
    final_paper = input[end]
    # prettyprint(final_paper)
    rowsums = mapslices(sum, final_paper, dims = 2)
    colsums = mapslices(sum, final_paper, dims = 1)
    return (vec(rowsums), vec(colsums))
end