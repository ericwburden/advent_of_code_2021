# Helper Functions -------------------------------------------------------------

const TargetRange = @NamedTuple begin
    x_min::Int64
    x_max::Int64
    y_min::Int64
    y_max::Int64
end

function targetrange(vals::Vector{Int64})::TargetRange
    (x_min, x_max, y_min, y_max) = vals
    return (x_min=x_min, x_max=x_max, y_min=y_min, y_max=y_max)
end


# Ingest the Data -------------------------------------------------------------

function ingest(path)
    re = r"x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)"
    m = match(re, readchomp(path))
    return targetrange([parse(Int, i) for i in m.captures])
end

