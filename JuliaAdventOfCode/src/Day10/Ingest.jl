function ingest(path)
    return open(path) do f
        [collect(line) for line in readlines(f)]
    end
end
