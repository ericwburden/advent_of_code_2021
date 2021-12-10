OPENING_BRACKETS = Set(['(', '[', '{', '<'])
CLOSING_BRACKETS = Set([')', ']', '}', '>'])
MATCHES = Dict([
    '(' => ')', '[' => ']', '{' => '}', '<' => '>',
    ')' => '(', ']' => '[', '}' => '{', '>' => '<'
])
POINTS = Dict([')' => 3, ']' => 57, '}' => 1197, '>' => 25137])

isopening(b) = b in OPENING_BRACKETS
isclosing(b) = b in CLOSING_BRACKETS
ismatch(lhs, rhs) = !ismissing(rhs) && !ismissing(lhs) && rhs == MATCHES[lhs] 

function getcorruptedchar(line)
    stack = []; sizehint!(stack, length(line))
    for bracket in line
        if isopening(bracket)
            push!(stack, bracket)
            continue
        end
        
        lastbracket = pop!(stack)
        ismatch(lastbracket, bracket) && continue
        return bracket            
    end
    return missing
end

function part1(input)
    total = 0
    for char in map(getcorruptedchar, input)
        ismissing(char) && continue
        total += POINTS[char]
    end
    return total
end
