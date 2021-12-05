using DataStructures

# Play each number on each board until all winners are found, then
# return the sum of the last winning board's unmarked numbers times
# the last number drawn.
function part2(numbers, boards)
    # Convert the Vector of boards into an OrderedSet to allow for
    # convenient iteration in order and easy removal of boards from
    # the set once they "win"
    boardset = OrderedSet{Board}(boards)
    for number in numbers
        for board in boardset
            if play!(number, board)
                # Return for the last winning board
                if length(boardset) == 1
                    unmarked = board.numbers[.!board.found]
                    return sum(unmarked) * number
                end

                # Remove any winning board from the OrderedSet
                delete!(boardset, board)
            end
        end
    end
    error("Could not find a winning board!")
end