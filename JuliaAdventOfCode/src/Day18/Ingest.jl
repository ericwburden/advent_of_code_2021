# Helper Functions -------------------------------------------------------------

# Data Structures --------------------------------------------------------------

mutable struct SnailfishValue
	value::Int64
	depth::Int64
end

const SnailfishNumber = Vector{SnailfishValue}


function snailfishnumber(s::AbstractString)
	depth = 0
	values = Vector{SnailfishValue}()
	for char in collect(s)
		if char == '['; depth += 1; end
		if char == ']'; depth -= 1; end
		if isdigit(char)
			value = parse(Int, char)
			sfvalue = SnailfishValue(value, depth)
			push!(values, sfvalue)
		end
	end
	return values
end


# Ingest the Data -------------------------------------------------------------

function ingest(path)
    return open(path) do f
        [snailfishnumber(line) for line in readlines(f)]
    end
end

