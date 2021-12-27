# No need to parse the input for this one, we're not actually using the full set
# of instructions, just the numbers from lines 5, 6, and 16 of each "chunk" of
# the input program. Reviewing these parameters led to the observation that 
# 'pairs' of input digits were connected in a "stack-wise" fashion, with a 
# set of instructions that contained a value of 26 on line 5 potentially 
# "canceling out" the previous digit with a value of 1 on line 5 of its 
# processing instructions. The result is that there's no actual code 
# *needed* to solve this day's puzzle. You can see where I've worked out the
# answers to my input in the comments below.

const PARAMS = [
    ( 1,  13,  0),  # d[1]  +  0 -  1 == d[14] -> d[1] -  1 == d[14] // 9  // 2
    ( 1,  11,  3),  # d[2]  +  3 -  9 == d[13] -> d[2] -  6 == d[13] // 9  // 7
    ( 1,  14,  8),  # d[3]  +  8 -  5 == d[4]  -> d[3] +  3 == d[4]  // 6  // 1
    (26,  -5,  5),  # d[4]  -  8 +  5 == d[3]  -> d[4] -  3 == d[3]  // 9  // 4
    ( 1,  14, 13),  # d[5]  + 13 -  5 == d[12] -> d[5] +  8 == d[12] // 1  // 1
    ( 1,  10,  9),  # d[6]  +  9 -  8 == d[9]  -> d[6] +  1 == d[9]  // 8  // 1
    ( 1,  12,  6),  # d[7]  +  6 - 14 == d[8]  -> d[7] -  8 == d[8]  // 9  // 9
    (26, -14,  1),  # d[8]  -  6 + 14 == d[7]  -> d[8] +  8 == d[7]  // 1  // 1
    (26,  -8,  1),  # d[9]  -  9 +  8 == d[6]  -> d[9] -  1 == d[6]  // 9  // 2
    ( 1,  13,  2),  # d[10] +  2 -  0 == d[11] -> d[10] + 2 == d[11] // 7  // 1
    (26,   0,  7),  # d[11] -  2 +  0 == d[10] -> d[11] - 2 == d[10] // 9  // 3
    (26,  -5,  5),  # d[12] - 13 +  5 == d[5]  -> d[12] - 8 == d[5]  // 9  // 9
    (26,  -9,  8),  # d[13] -  3 +  9 == d[2]  -> d[13] + 6 == d[2]  // 3  // 1
    (26,  -1, 15)   # d[14] -  0 +  1 == d[1]  -> d[14] + 1 == d[1]  // 8  // 1
] 


# Largest model number:  99691891979938
# Smallest model number: 27141191213911

# This function can be used to check whether a given number is a valid model
# number, according to the MONAD program.
function isvalid(n::Int64)
    ndigits = reverse(digits(n))

    # Valid model numbers don't contain `0` as a digit
    0 ∈ ndigits && return false
    stack = []; sizehint!(stack, length(ndigits))

    for (w, (optype, correction, offset)) in zip(ndigits, PARAMS)
        if optype == 1
            push!(stack, w + offset)
            continue
        end
        stack[end] + correction == w && pop!(stack)
    end

    # In a valid model number, half the digits will be "canceled" out by the
    # other half, leaving an empty stack
    return isempty(stack)
end

@assert isvalid(99691891979938)
@assert isvalid(27141191213911)

# Interestingly, due to the fact that digits 5 and 12 (and digits 7 and 8) 
# have an offset of 8, these two model numbers are the ONLY valid model numbers.

solve() = (99691891979938, 27141191213911)


