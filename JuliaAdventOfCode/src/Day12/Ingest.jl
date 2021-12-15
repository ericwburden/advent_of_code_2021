# Some Useful Data Structures -------------------------------------------------

# Yes, there are four types of caves. Large caves, small caves, start caves, and
# end caves. Yes, they have different fields. Sue me. Each cave indicates the size, 
# name, and index of the cave, if it's important for that type of cave. The 
# indices are used later to determine whether a cave has already been visited.
abstract type Cave end

struct StartCave <: Cave end
struct EndCave   <: Cave end
struct LargeCave <: Cave name::String end
struct SmallCave <: Cave
    name::String
    index::Int
end

# Given a name and index, produce the appropriate type of Cave depending
# on whether the name is uppercase or not.
issmallcave(S) = all(islowercase, S) && S ∉ ["start", "end"]
Cave(s::AbstractString, idx::Int)::SmallCave = SmallCave(s, idx)
function Cave(s::AbstractString, ::Nothing)::Cave
    s == "start" && return StartCave()
    s == "end"   && return EndCave()
    return LargeCave(s)
end


# Ingest the Data File ---------------------------------------------------------

# Read in each line of the input file and parse it as an 'edge'. The final product
# here will be a Dict, where the keys are `Cave`s and the values are the list of
# other `Cave`s the key Cave is connected to. This behaves similarly to an 
# adjacency list, except you can look up cave connections in O(1) time.
function ingest(path)
    paths = open(path) do f
        [split(line, "-") for line in readlines(f)]
    end

    cavemap = Dict{Cave, Vector{Cave}}()
    indexes = Dict{String,Int}()
    for path in paths
        # Need to add entries to the output dictionary for both paths, from
        # the left cave to the right, and from the right cave to the left.
        (left, right) = path

        # Get the appropriate index for each cave. If there's already an 
        # assigned index for that cave name, just use it, otherwise use one more
        # than the total number of caves already indexed. Only do this if the
        # cave name is all lowercase, a small cave.
        if issmallcave(left) && get(indexes, left, 0) == 0
            indexes[left] = length(indexes) + 1
        end
        if issmallcave(right) && get(indexes, right, 0) == 0
            indexes[right] = length(indexes) + 1
        end

        # Make the `Caves`!
        leftcave  = Cave(left,  get(indexes, left, nothing))
        rightcave = Cave(right, get(indexes, right, nothing))

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
