using ..JuliaAdventOfCode: getinput

abstract type AbstractDirection end

struct Forward <: AbstractDirection mag::Integer end
struct Down    <: AbstractDirection mag::Integer end
struct Up      <: AbstractDirection mag::Integer end

function todirection(s::AbstractString)::AbstractDirection
    (dirstr, magstr) = split(s)
    mag = parse(Int, magstr)
    dirstr == "forward" && return Forward(mag)
    dirstr == "down"    && return Down(mag)
    dirstr == "up"      && return Up(mag)
    DomainError(s, "cannot be converted to Direction") |> throw
end

function ingest(path)
    open(path) do f
        [todirection(s) for s in readlines(f)]
    end
end