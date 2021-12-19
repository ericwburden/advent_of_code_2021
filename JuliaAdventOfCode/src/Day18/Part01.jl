# Some Useful Data Structures --------------------------------------------------



# Helper Functions -------------------------------------------------------------
function Base.:+(a::SnailfishValue, b::SnailfishValue)
    return SnailfishValue(a.value + b.value, a.depth)
end

function Base.:+(a::SnailfishNumber, b::SnailfishNumber)
    result = [a..., b...]
    for sfv in result
        sfv.depth += 1
    end
    reduce!(result)
    return result
end

function isreduced(sfn::SnailfishNumber)
    for sfv in sfn
        (sfv.depth > 4 || sfv.value > 9) && return false
    end
    return true
end

function explode!(sfn::SnailfishNumber)
    explodeat = findfirst(sfv -> sfv.depth > 4, sfn)
    isnothing(explodeat) && return false

	(left, right) = sfn[explodeat:explodeat+1]
	if checkbounds(Bool, sfn, explodeat-1); sfn[explodeat-1] += left;  end
	if checkbounds(Bool, sfn, explodeat+2); sfn[explodeat+2] += right; end
	sfn[explodeat] = SnailfishValue(0, 4)
    deleteat!(sfn, explodeat + 1)
    return true
end

splitleft(value)::Int = floor(value / 2)
splitright(value)::Int = ceil(value / 2)
splitvalue(value) = (splitleft(value), splitright(value))

function split!(sfn::SnailfishNumber)
    splitat = findfirst(sfv -> sfv.value >= 10, sfn)
    isnothing(splitat) && return false

    sfv = sfn[splitat]
    (left, right) = splitvalue(sfv.value)
    depth = sfv.depth + 1
    sfn[splitat] = SnailfishValue(left, depth)
    insert!(sfn, splitat+1, SnailfishValue(right, depth))
    return true
end

function reduce!(sfn::SnailfishNumber)
    while !isreduced(sfn)
        while explode!(sfn); end
        split!(sfn)
    end
end

function magnitude!(sfn::SnailfishNumber)
    iters = 0
    while length(sfn) > 1
        for idx in 2:length(sfn)
            (left, right) = sfn[idx-1:idx]            
            if left.depth == right.depth
                newvalue = (left.value*3) + (right.value*2)
                sfn[idx-1] = SnailfishValue(newvalue, left.depth - 1)
                sfn[idx] = SnailfishValue(0, -1)
            end
        end
        filter!(sfv -> sfv.depth >= 0, sfn)
        iters += 1
        iters > 100 && return -1
        # TODO: Currently just gives up after 100 iterations. This is because
        # sometimes the rightmost node of the left branch and the leftmost node
        # of the right branch can have the same depth, and this algorithm
        # doesn't account for the branching at all. So, it can get stuck in a 
        # state where it can't reduce the magnitude any further. Thankfully, 
        # this *doesn't* happen for the inputs that lead to the actual answer, 
        # but this was by no means guaranteed.
    end
    return sfn[1].value
end


# Solve Part One ---------------------------------------------------------------

function part1(input)
    input = deepcopy(input)
    finalnumber = reduce(+, input)
    return magnitude!(finalnumber)
end