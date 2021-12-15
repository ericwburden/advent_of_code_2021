# Some Useful Data Structures --------------------------------------------------
using DataStructures: BinaryMinHeap

addtoidx(x) = x + idx
inbounds(i, M) = checkbounds(Bool, M, i)

function neighbors(idx::CartesianIndex, M::AbstractMatrix)
    offsets = [CartesianIndex( 1, 0), CartesianIndex(0,  1),
               CartesianIndex(-1, 0), CartesianIndex(0, -1)]
    neigbhoridxs = [offset + idx for offset in offsets]
    return filter(i -> inbounds(i, M), neigbhoridxs)
end

# Find the minimum path from `start` to `finish` on `map` using Dijkstra's algorithm
function minpath(start, finish, map)
    distances = fill(typemax(UInt16), size(map))
    distances[1, 1] = 0

    heap = BinaryMinHeap([(0, CartesianIndex(1, 1))])
    visited = Set{CartesianIndex}()

    while !isempty(heap)
        (distance, current) = pop!(heap)
        current in visited && continue
        current == finish && return distances[finish]
        push!(visited, current)

        for neighbor in neighbors(current, map)
            traveldistance = distance + map[neighbor]

            if traveldistance < distances[neighbor]
                distances[neighbor] = traveldistance
            end

            push!(heap, (distances[neighbor], neighbor))
        end
    end
    error("Could not find a path from $start to $finish!")
end


# Solve Part One ---------------------------------------------------------------

function part1(input)
    start  = CartesianIndex(1,1)
    finish = CartesianIndex(size(input))
    return minpath(start, finish, input)
end