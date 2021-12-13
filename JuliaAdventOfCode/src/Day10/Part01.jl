# Some useful constants
OPENING_BRACKETS = Set(['(', '[', '{', '<'])
CLOSING_BRACKETS = Set([')', ']', '}', '>'])
MATCHES = Dict([
    '(' => ')', '[' => ']', '{' => '}', '<' => '>',
    ')' => '(', ']' => '[', '}' => '{', '>' => '<'
])
POINTS = Dict([')' => 3, ']' => 57, '}' => 1197, '>' => 25137])

# Some useful utility functions
isopening(b) = b in OPENING_BRACKETS
isclosing(b) = b in CLOSING_BRACKETS
ismatch(lhs, rhs) = !ismissing(rhs) && !ismissing(lhs) && rhs == MATCHES[lhs] 

# Search a line for the "corrupted" character by putting all opening
# brackets onto a stack, removing them when we find a match, and
# returning the unmatched bracket if it doesn't match.
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

# Get the "corrupted" character from each line, look up its score,
# then add it to the total score.
function part1(input)
    total = 0
    for char in map(getcorruptedchar, input)
        ismissing(char) && continue
        total += POINTS[char]
    end
    return total
end
