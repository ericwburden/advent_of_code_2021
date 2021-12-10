# Given a `RawOutput` (a Tuple of letter combinations), identify which
# ones represent a number containing a unique number of segments, and
# just count how many you found.
function counteasydigits(outputs::RawOutputs)::Int
    easyfilter(output) = filter(x -> length(x) in [2, 3, 4, 7], output)
    (outputs
     |> easyfilter
     |> length)
end

function part1(input)
    tooutput(RI) = map(x -> x.outputs, RI)
    easycount(input) = map(counteasydigits, input)
    (input
     |> tooutput
     |> easycount
     |> sum)
end
