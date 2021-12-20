# Data Structures --------------------------------------------------------------

const Beacon = NTuple{3,Int}
const Scanner = Set{Beacon}
const Scanners = Dict{Int,Scanner}


# Helper Functions -------------------------------------------------------------

scannerid(s) = parse(Int, match(r"--- scanner (\d+) ---", s)[1])
parsebeacon(s) = NTuple{3,Int}(parse(Int,n) for n in split(s, ","))
function parsescanner(f)
	id = readline(f) |> scannerid
	beacons = Set(parsebeacon(s) for s in split(readuntil(f, "\n\n")))
	return (id, beacons)
end



# Ingest the Data -------------------------------------------------------------

function ingest(path)
    return open(path) do f
		entries = []
		while !eof(f); push!(entries, parsescanner(f)); end
		Scanners(entries)
    end
end

