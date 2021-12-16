# Multiple Dispatch! -----------------------------------------------------------

# A new sub-type of `Packet` for each of the Operator types. In a 'real' 
# application, I'd probably re-define Operator as an abstract type and
# sub-type from there. 
struct SumPacket  <: Packet version::Int; packets::Vector{Packet} end
struct ProdPacket <: Packet version::Int; packets::Vector{Packet} end
struct MinPacket  <: Packet version::Int; packets::Vector{Packet} end
struct MaxPacket  <: Packet version::Int; packets::Vector{Packet} end
struct GtPacket   <: Packet version::Int; packets::Vector{Packet} end
struct LtPacket   <: Packet version::Int; packets::Vector{Packet} end
struct EqPacket   <: Packet version::Int; packets::Vector{Packet} end

# Honestly, this is just single dispatch. Define a method for each type of
# Packet that evaluates its value. For `Literal`s, that's just the stored
# value and everything else is evaluated in terms of that.
eval(packet::Literal)    = packet.value
eval(packet::SumPacket)  = sum(eval(sub) for sub in packet.packets)
eval(packet::ProdPacket) = prod(eval(sub) for sub in packet.packets)
eval(packet::MinPacket)  = minimum(eval(sub) for sub in packet.packets)
eval(packet::MaxPacket)  = maximum(eval(sub) for sub in packet.packets)
eval(packet::GtPacket)   = eval(packet.packets[1]) >  eval(packet.packets[2])
eval(packet::LtPacket)   = eval(packet.packets[1]) <  eval(packet.packets[2])
eval(packet::EqPacket)   = eval(packet.packets[1]) == eval(packet.packets[2])

# We need to go back and classify the `Packets` from before according to their
# newly revealed `Operator` sub-type. `Literal`s stay the same.
classify(packet::Literal) = packet
function classify(packet::Operator)
    version = packet.version
    subpackets = [classify(sub) for sub in packet.packets]
    packet.typeid == 0 && return SumPacket(version, subpackets)
    packet.typeid == 1 && return ProdPacket(version, subpackets)
    packet.typeid == 2 && return MinPacket(version, subpackets)
    packet.typeid == 3 && return MaxPacket(version, subpackets)
    packet.typeid == 5 && return GtPacket(version, subpackets)
    packet.typeid == 6 && return LtPacket(version, subpackets)
    packet.typeid == 7 && return EqPacket(version, subpackets)
    error("Could not clasify $packet")
end


# Solve Part Two ---------------------------------------------------------------

# Parse the superpacket from our input, identify the sub-types of all the 
# `Packet`s, and evaluate them. In an ideal world, we would have known about the
# `Operator` sub-types ahead of time and included that logic in our `nextpacket!()`
# function.
function part2(input)
    bits = deepcopy(input)
    superpacket = nextpacket!(bits)
    classified = classify(superpacket)
    return eval(classified)
end