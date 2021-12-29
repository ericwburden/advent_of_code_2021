# Data Structures --------------------------------------------------------------

# We'll store each `Beacon` as a Tuple of (x, y, z) coordinates, each `Scanner`
# as a Set of `Beacon`s, and maintain a collection of `Scanner`s as a Dict where
# each key is the scanner ID and value is the set of beacons associated with
# that scanner.
const Beacon = NTuple{3,Int}
const Scanner = Set{Beacon}
const Scanners = Dict{Int,Scanner}


# Helper Functions -------------------------------------------------------------

# Functions to help parse a chunk of the input into an (<ID>, `Scanner`) pair

# Parse a line starting a scanner chunk into the scanner ID
scannerid(s) = parse(Int, match(r"--- scanner (\d+) ---", s)[1])

# Parse a line containing beacon coordinates into a `Beacon`
parsebeacon(s) = NTuple{3,Int}(parse(Int,n) for n in split(s, ","))

# Parse a "scanner chunk" (from the "--- scanner ## ---" line to the next blank
# line) into an (<ID>, `Scanner`) pair, for conversion into a Dict entry.
function parsescanner(f)
	id = readline(f) |> scannerid
	beacons = Set(parsebeacon(s) for s in split(readuntil(f, "\n\n")))
	return (id, beacons)
end



# Ingest the Data -------------------------------------------------------------

# Parse scanner chunks until the file is empty!
function ingest(path)
    return open(path) do f
		entries = []
		while !eof(f); push!(entries, parsescanner(f)); end
		Scanners(entries)
    end
end

