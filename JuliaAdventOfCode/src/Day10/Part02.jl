SCORE_FOR = Dict([')' => 1, ']' => 2, '}' => 3, '>' => 4])

notcorrupted(line) = ismissing(getcorruptedchar(line))

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

function calculatescore(unmatched)
    total = 0
    for bracket in unmatched
        total *= 5
        total += SCORE_FOR[bracket]
    end
    return total
end


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