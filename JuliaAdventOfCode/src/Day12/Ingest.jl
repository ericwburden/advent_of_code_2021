abstract type Cave end
struct LargeCave <: Cave
    name::String
    index::Int
end
struct SmallCave <: Cave
    name::String
    index::Int
end

function Cave(s::AbstractString, idx::Int)::Cave
    return all(isuppercase, s) ? LargeCave(s, idx) : SmallCave(s, idx)
end

function ingest(path)
    paths = open(path) do f
        [split(line, "-") for line in readlines(f)]
    end

    cavemap = Dict{Cave, Vector{Cave}}()
    indexes = Dict{String,Int}()
    for path in paths
        (left, right) = path

        if get(indexes, left, 0) == 0
            indexes[left] = length(indexes) + 1
        end
        if get(indexes, right, 0) == 0
            indexes[right] = length(indexes) + 1
        end

        leftcave = Cave(left, indexes[left])
        rightcave = Cave(right, indexes[right])

        # Add the left cave to the cavemap
        destinations = get(cavemap, leftcave, Vector{Cave}())
        push!(destinations, rightcave)
        cavemap[leftcave] = destinations

        # Add the right cave to the cavemap
        destinations = get(cavemap, rightcave, Vector{Cave}())
        push!(destinations, leftcave)
        cavemap[rightcave] = destinations
    end
    return cavemap
end
