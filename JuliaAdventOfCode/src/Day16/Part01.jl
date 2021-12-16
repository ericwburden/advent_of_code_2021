# Some Useful Data Structures --------------------------------------------------

# Types for the different types of packets we might find
abstract type Packet end
struct Literal <: Packet
    version::Int
    value::Int
end
struct Operator <: Packet
    version::Int
    typeid::Int
    packets::Vector{Packet}
end

# Used in lieu of an enum for dispatching which strategy to use for
# parsing the sub-packets of an `Operator` packet.
abstract type SubPacketStrategy end
struct BitwiseStrategy    <: SubPacketStrategy end
struct PacketwiseStrategy <: SubPacketStrategy end


# Helper Functions -------------------------------------------------------------

# Makes working with the input bits a lot nicer. Since the input bits are 
# arranged in reverse order, we can `pop!()`, to get the first bit and remove
# it from the bits vector. These helpers let us pop multiple bits from the
# bits vector (`popn!()`) or easily extract a decimal number from the end of
# the bits vector (`pop2dec!()`).
todecimal(x) = sum(D*2^(P-1) for (D, P) in zip(x, length(x):-1:1))
popn!(x, n) = [pop!(x) for _ in 1:n]
pop2dec!(x, n) = todecimal(pop!(x) for _ in 1:n)

# Round a BitVector down to the nearest full byte, discarding extra bits. Each
# packet may have extra empty bits at the end, this helps to clean those off
# before searching for the next packet.
function roundtobytes!(bits::BitVector)
    targetlen = (length(bits) ÷ 8) * 8      # Number of bits in full bytes left
    bitstoremove = length(bits) - targetlen 
    popn!(bits, bitstoremove)
end

# Parse a packet off the end of the `bits` BitVector. Start pulling bits from
# the end and working backwards.
function nextpacket!(bits::BitVector; issubpacket = false)::Packet
    version = pop2dec!(bits, 3)
    typeid  = pop2dec!(bits, 3)

    # If the `typeid` is 4, it's a Literal packet. Otherwise, it's an Operator
    packet = if typeid == 4
        value = literalvalue!(bits)
        Literal(version, value)
    else
        # The 'length type ID' mentioned in the puzzle description is a single
        # bit, so either true or false. If it's `1` (true), then we know how
        # many sub-packets we have. Otherwise, we're given the number of bytes
        # in the sub-packets and have to parse from there.
        countingstrategy = pop!(bits) ? PacketwiseStrategy : BitwiseStrategy
        subpackets = subpackets!(countingstrategy, bits)
        Operator(version, typeid, subpackets)
    end

    # Round down to the nearest byte if we're not parsing a sub-packet
    issubpacket || roundtobytes!(bits)

    return packet
end

# The value for a Literal packet comes from the bits following the type ID. The
# bits for the value are split into 5-bit chunks, where the first bit indicates
# whether or not it's the last chunk, and the remaining 4 bits are concatenated
# to provide the binary representation of the final value.
function literalvalue!(bits::BitVector)::Int
    valuebits = BitVector()
    keepgoing = true
    while keepgoing
        keepgoing = pop!(bits)
        append!(valuebits, popn!(bits, 4))
    end
    return todecimal(valuebits)
end

# If we're using the `BitwiseStrategy` for parsing sub-packets (from the 
# 'length type ID' value), then we start by checking the total number 
# of bits left before we start, then parsing bits off the end until we've
# used up the number of bits specified in `bitstoread`.
function subpackets!(::Type{BitwiseStrategy}, bits::BitVector)::Vector{Packet}
    packets = Vector{Packet}()
    bitstoread = pop2dec!(bits, 15)     # Specified in the puzzle description
    bitstostart = length(bits)
    while (bitstostart - length(bits)) < bitstoread
        push!(packets, nextpacket!(bits, issubpacket = true))
    end
    return packets
end

# If we're using the `PacketwiseStrategy`, it means we were given the number of
# sub-packets to parse. So, we just pull that many sub-packets from the end
# of the bits vector. This seems like a superior encoding, honestly.
function subpackets!(::Type{PacketwiseStrategy}, bits::BitVector)::Vector{Packet}
    packetstoread = pop2dec!(bits, 11)  # Specified in the puzzle description
    return [nextpacket!(bits, issubpacket = true) for _ in 1:packetstoread]
end

# This function reads a sequence of packets from the input. Turns out, the 
# actual input is a single large `Operator` containing a bunch of
# sub-packets, so this isn't really necessary. I'm still leaving it in for
# educational purposes, but I don't use it either solution.
function topackets!(bits::BitVector)
    packets = Vector{Packet}()
    while !isempty(bits)
        push!(packets, nextpacket!(bits))
    end
    return packets
end

# Two different functions for summing the versions of a Packet. The sum of 
# versions for a `Literal` packet is just its version number. For an `Operator`, 
# we need to recursively check all the sub-packets and sum their versions.
sumversions(packet::Literal) = packet.version

function sumversions(packet::Operator)
    return packet.version + sum(sumversions(p) for p in packet.packets)
end


# Solve Part One ---------------------------------------------------------------

# Parse the one big packet from our input, then count the versions of all
# its sub-packets (and their sub-packets, and their sub-packets' sub-packets...)
function part1(input)
    bits = deepcopy(input)
    superpacket = nextpacket!(bits)
    return sumversions(superpacket)
end