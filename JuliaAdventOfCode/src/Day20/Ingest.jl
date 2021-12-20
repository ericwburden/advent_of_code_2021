# Data Structures --------------------------------------------------------------

const Point = NTuple{2,Int64}
const Image = Dict{Point,Bool}

# Helper Functions -------------------------------------------------------------

# None this time


# Ingest the Data -------------------------------------------------------------

function ingest(path)
    return open(path) do f
		# Parse the first line into a BitVector, with '#' => 1, '.' => 0
		algostr = readuntil(f, "\n\n")
		algo = collect(algostr) .== '#'

		# Parse the rest of the lines into a Dict of (row, col) => true/false, 
		# where the value is true if the corresponding row/col of the input
		# is a '#'
		image = Dict{Point,Bool}()
		imagestr = readchomp(f)
		for (row, line) in enumerate(split(imagestr))
			for (col, char) in enumerate(collect(line))
				image[(row,col)] = char == '#'
			end
		end

		(algo, image)
    end
end

