issmall(C::Cave) = isa(C, SmallCave)
islarge(C::Cave) = isa(C, LargeCave)
isstart(C::Cave) = C.name == "start"
isend(C::Cave) = C.name == "end"

const Visited = Set{Cave}
const CaveMap = Dict{Cave, Vector{Cave}}
const ExploreQueue = Vector{Tuple{Visited,Cave}}

function getstart(map::CaveMap)
    for cave in keys(map)
        isstart(cave) && return cave
    end
    error("Could not find starting cave")
end

function findvisited(map::CaveMap)::Vector{Visited}
    startcave = getstart(map)
    queue = ExploreQueue([(Visited([startcave]), startcave)])
    visitlist = Vector{Visited}()

    while !isempty(queue)
        (visitedsofar, cave) = pop!(queue)

        if isend(cave)
            push!(visitlist, visitedsofar)
            continue
        end
        
        for nextcave in get(map, cave, [])
            isstart(nextcave) && continue
            issmall(nextcave) && nextcave in visitedsofar && continue
            visited = Visited([visitedsofar..., nextcave])
            pushfirst!(queue, (visited, nextcave))
        end
    end
    return visitlist
end

function part1(input)
    visitlists = findvisited(input)
    return length(visitlists)
end