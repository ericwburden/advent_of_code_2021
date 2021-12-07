# Used to indicate whether a given line index is for a row
# or a column
abstract type AbstractIndexType end
struct RowIndex <: AbstractIndexType idx::Int end
struct ColIndex <: AbstractIndexType idx::Int end

# A struct to represent the state of an individual bingo board
# Contains fields for:
# - indexmap:   A Dict whose keys are values in the board and whose
#               values are the index of that board value
# - numbers:    A 2D matrix of the board values
# - found:      A mask for `numbers` to indicate which board numbers
#               have been called
# - linecounts: A Dict used to determine when a full column or row
#               has been drawn. The keys are an AbstractIndexType
#               indicating the line(s) of the number on the board.
#               The values are the count of numbers in that
#               row/column that have been drawn.
mutable struct Board
    indexmap::Dict{Int, Int}
    numbers::Matrix{Int}
    found::BitMatrix
    linecounts::Dict{AbstractIndexType, Int}
end

# Constructor for a `Board`, generates the other fields from `numbers`
function Board(numbers::Matrix{Int}) 
    # Build the `indexmap`
    mapnumbers(n) = map(i -> (numbers[i], i), n)
    (indexmap
        =  numbers
        |> eachindex
        |> mapnumbers
        |> Dict)
    
    found = falses(size(numbers))
    linecounts = Dict()
    Board(indexmap, numbers, found, linecounts)
end

# Call a number for a particular board. As in bingo, when a number
# is called, it should be marked on the board. This function 
# marks which number was called in the board's `found` BitMatrix
# and updates the board's `linecounts` . If playing that number
# fills out a row or column, return `true`, otherwise return `false`.
function play!(number::Int, board::Board)::Bool
    haskey(board.indexmap, number) || return false
    idx = get(board.indexmap, number, 0)
    board.found[idx] = true

    (row, col) = Tuple(CartesianIndices(board.numbers)[idx])
    boardwins = false
    linecountkeys = [RowIndex(row), ColIndex(col)]
    for key in linecountkeys
        linecount = get(board.linecounts, key, 0)
        board.linecounts[key] = linecount + 1
        if linecount + 1 >= 5; boardwins = true; end
    end

    return boardwins
end

# Read in an parse the contents of the input file
function ingest(path)
    open(path) do f
        # Read the first line of numbers and parse into 
        # an array of Ints
        numstr = readuntil(f, "\n\n")
        numbers = [parse(Int, s) for s in split(numstr, ",")]

        # Utility functions to help with parsing 
        mergevectors(x) = reduce(hcat, x)
        alltoint(x) = parse.(Int, x)
        intoboard = Board ∘ collect ∘ transpose
        boards = []

        # Until the end of the file, read up to the next empty line,
        # split the lines, merge into a Matrix, convert all the Matrix
        # strings to integers, transpose the Matrix, then pass it to
        # the Board constructor.
        while !eof(f)
            boardstr = readuntil(f, "\n\n")
            (boardnums 
                = [split(s) for s in split(boardstr, "\n")]
                |> mergevectors
                |> alltoint
                |> intoboard)
            push!(boards, boardnums)
        end
        (numbers, boards) # Return numbers and boards in a Tuple
    end
end
