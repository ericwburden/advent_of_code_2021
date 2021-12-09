function findlowpoints(pointmap::Matrix{Int64})
    rightshift = circshift(pointmap, (0, 1))
    leftshift  = circshift(pointmap, (0, -1))
    upshift    = circshift(pointmap, (-1, 0))
    downshift  = circshift(pointmap, (1, 0))

    rightshift[:,1]  .= typemax(Int64)
    leftshift[:,end] .= typemax(Int64)
    upshift[end,:]   .= typemax(Int64)
    downshift[1,:]   .= typemax(Int64)

    shifts = [rightshift, leftshift, upshift, downshift]
    return mapreduce(S -> S .> pointmap, .&, shifts)
end

function part1(input)
    lowpoints = findlowpoints(input)
    return sum(input[lowpoints] .+ 1)
end
