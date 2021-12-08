const SignalPatterns = NTuple{10,String}
const RawOutputs = NTuple{4,String}
const RawInput = @NamedTuple {patterns::SignalPatterns, outputs::RawOutputs}

function parseline(s::AbstractString)::RawInput
    (patternstr, outputstr) = split(s, " | ")
    sortstr = join ∘ sort ∘ collect
    patterns = Tuple([sortstr(s) for s in split(patternstr)])
    outputs = Tuple([sortstr(s) for s in split(outputstr)])
    return (patterns = patterns, outputs = outputs)
end

function ingest(path)
    return open(path) do f
        [parseline(s) for s in readlines(f)]
    end
end
