# Create an Iterator over Generations of Fish Schools -------------------------
struct School
    agegroups::Vector{Int64}
end

# This function is called for the first iteration
function Base.iterate(iter::School)
    groups = copy(iter.agegroups)
    (sum(groups), groups)
end

# This function is called for each subsequent iteration
# Instead of keeping track of each fish and its progeny, we group all
# the fish by age and calculate the size of the next generation. Each
# generation/iteration creates `groups[1]` new fish at age `8` and rotates
# the group counts one to the left (such that the fish that were age `2` 
# are now age `1`)
function Base.iterate(iter::School, groups::Vector{Int64})
    groups = circshift(groups, -1)
    groups[7] += groups[9]
    (sum(groups), groups)
end

# Used to get the `nth` generation of a school. 
function Base.getindex(school::School, i::Int)
    for (generation, groups) in enumerate(school)
        generation > i && return groups
    end
end

# Solve the puzzle, creating an iterator over generations of a 
# `School` and summing the values for a given day.
function solve(input, days)
    school = School(input)
    return sum(school[days])
end
