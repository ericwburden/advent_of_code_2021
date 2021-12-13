# Another useful constant
SCORE_FOR = Dict([')' => 1, ']' => 2, '}' => 3, '>' => 4])

# And another utility function!
notcorrupted(line) = ismissing(getcorruptedchar(line))

# Similar to before. This time, we start adding  brackets from
# the end of the line to our stack. If it's a closing bracket, 
# we add it to our stack. If it's an opening bracket, we get the 
# closing bracket off the top of our stack. If they match, we just
# keep going. If not, we add the bracket to our list of unmatched
# opening brackets.
function getclosingbrackets(line)
    closingbrackets = []; sizehint!(closingbrackets, length(line))
    stack = []; sizehint!(stack, length(line))

    while !isempty(line)
        bracket = pop!(line)

        if isclosing(bracket)
            push!(stack, bracket)
            continue
        end

        if isopening(bracket)
            stackbracket = isempty(stack) ? missing : pop!(stack)
            ismatch(bracket, stackbracket) && continue
            push!(closingbrackets, MATCHES[bracket])
        end
    end
    return closingbrackets
end

# Given a list of opening brackets, look up each bracket's corresponding
# score and add it to a running total.
function calculatescore(unmatched)
    total = 0
    for bracket in unmatched
        total *= 5
        total += SCORE_FOR[bracket]
    end
    return total
end


# For each line, get the unmatched opening brackets, and calculate the
# score for that line. With all the line scores, we just sort them and
# return the score from the middle.
function part2(input)
    (scores
     = input
     |> (lines -> filter(notcorrupted, lines))
     |> (lines -> map(getclosingbrackets, lines))
     |> (lines -> map(calculatescore, lines)))

    sort!(scores)
    middle = (length(scores) + 1) ÷ 2
    return scores[middle]
end