function ingest(path)
    fish = open(path) do f
        readsplit(x) = split(readchomp(x), ",")
        [parse(Int, s) for s in readsplit(f)]
    end

    # Instead of reporting back the fish individually, return a
    # Vector of length `9` where each index represents the number 
    # of fish of age `idx - 1` . (Julia is 1-indexed)
    groups = zeros(Int64, 9)
    for f in fish
        groups[f+1] += 1
    end
    return groups
end
