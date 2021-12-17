# Some Useful Data Structures --------------------------------------------------

# I find it helpful to name my Types according to their use. 
const Velocity = @NamedTuple{x::Int64, y::Int64}
const Position = @NamedTuple{x::Int64, y::Int64}
const VelocityRange = @NamedTuple{x::UnitRange{Int64}, y::StepRange{Int64,Int64}}

# Helper Functions -------------------------------------------------------------

# These little functions do a lot of work. 
# - `triangle()` returns the `nth` triangle number (or Gaussian sum), the sum of
#   the sequence of numbers up to and including `n`.
# - `distanceat()` calculates the distance traveled for a given velocity of `V`
#   at time `T`. Because the puzzle description indicates that velocity degrades
#   at a constant rate over time, the general formula for distance is
#   `position at time T = (initial velocity x T) - loss in velocity`, where the
#   loss in velocity at any given time is the sum of all the prior losses.
# - `peak()` returns the maximum distance traveled for initial velocity `V₀`.
#   This corresponds to the distance when the time matches the initial velocity,
#   after which the accumulated velocity loss is larger than `V₀ × T`.
triangle(n)       = (n^2 + n) ÷ 2
distanceat(V₀, T) = (V₀ * T) - triangle(T - 1)
peak(V₀)          =  distanceat(V₀, V₀)

# Given an initial velocity and a time, calculate the position of the launched
# probe at `time`. In the x-direction, this is either the distance at `time`, or
# the peak distance if `time` is greater than the initial velocity (the probe
# will not travel backwards once it reaches peak distance).
function positionat(initial::Velocity, time::Int64)::Position
    (v_x0, v_y0) = initial
    p_yt = distanceat(v_y0, time)
    p_xt = time >= v_x0 ? peak(v_x0) : distanceat(v_x0, time)
    return (x=p_xt, y=p_yt)
end

# Identify the possible initial x and y velocities for a given `target`.
function velocityrange(target::TargetRange)::VelocityRange
    # The smallest possible x velocity that will reach the target is the
    # velocity where `triangle(v_x)` is at least equal to the minimum
    # range of x in the target. Any lower velocity that this will not reach
    # the distance of `target.x_min`. The maximum x velocity is just the
    # maximum range of x in the target, since the probe could theoretically
    # be shot straight at that point.
    v_xmin = 0
    while triangle(v_xmin) < target.x_min; v_xmin += 1; end
    v_xrange = v_xmin:target.x_max

    # The largest possible y velocity is the one that, when reaching the point
    # of y == 0, will not overshoot the target on the next step. This works out
    # to be the absolute value of `target.y_min`. This range is given backwards,
    # since it is assumed that the maximum height will be found at larger values
    # for y velocity.
    v_ymax = abs(target.y_min)
    v_yrange = v_ymax:-1:target.y_min

    return (x=v_xrange, y = v_yrange)
end

# Given the initial velocity of a probe, determine whether that probe will land
# in the target zone. 
function willhit(initial::Velocity, target::TargetRange)::Bool
    # Starting at the initial position of 0, 0 and time 0
    (x_t, y_t) = (0, 0)
    time = 0

    # Check the position of the probe at subsequent times until it reaches a
    # position either to the right or below the target area. If, during this
    # search, the probe position is found to be within the target area, return
    # true. Otherwise, return false.
    while x_t <= target.x_max && y_t >= target.y_min
        x_t >= target.x_min && y_t <= target.y_max && return true
        (x_t, y_t) = positionat(initial, time)
        time += 1
    end
    return false
end

# Solve Part One ---------------------------------------------------------------

# Starting with the range of possible velocities, check each combination of 
# x and y velocities until an x/y velocity is found that lands in the target
# area. Since we're counting down from the maximum possible y velocity, the
# first probe we find that lands in the target will reach the maximum 
# height, so just return the peak of that y velocity.
function part1(input)
    v_range = velocityrange(input)

    for (v_x, v_y) in Iterators.product(v_range...)
        initial = (x=v_x, y=v_y)
        willhit(initial, input) && return peak(v_y)
    end
    error("Could not find maximum Y for $input")
end