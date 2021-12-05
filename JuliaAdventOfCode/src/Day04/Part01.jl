# Play each number on each board until a winner is found, then
# return the sum of the winning board's unmarked numbers times
# the last number drawn.
function part1(numbers, boards)
    for number in numbers
        for board in boards
            if play!(number, board)
                unmarked = board.numbers[.!board.found]
                return sum(unmarked) * number
            end
        end
    end
    error("Could not find a winning board!")
end