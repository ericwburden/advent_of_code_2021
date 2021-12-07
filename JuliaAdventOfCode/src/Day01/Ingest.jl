function ingest(path)
    open(path) do f
        [parse(Int, s) for s in readlines(f)]
    end
end