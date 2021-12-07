function ingest(path)
    return open(inputpath) do f
        readsplit(x) = split(readchomp(x), ",")
        [parse(Int, s) for s in readsplit(f)]
    end
end
