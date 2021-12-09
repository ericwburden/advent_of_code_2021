function findlowpoints(pointmap::Matrix{T}) where T <: Integer
    rightshift = circshift(pointmap, (0, 1))
    leftshift  = circshift(pointmap, (0, -1))
    upshift    = circshift(pointmap, (-1, 0))
    downshift  = circshift(pointmap, (1, 0))

    rightshift[:,1]  .= typemax(T)
    leftshift[:,end] .= typemax(T)
    upshift[end,:]   .= typemax(T)
    downshift[1,:]   .= typemax(T)

    shifts = [rightshift, leftshift, upshift, downshift]
    return mapreduce(S -> S .> pointmap, .&, shifts)
end

function part1(input)
    lowpoints = findlowpoints(input)
    return sum(input[lowpoints] .+ 1)
end
