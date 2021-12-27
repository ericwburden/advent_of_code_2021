# Data Structures --------------------------------------------------------------

abstract type Amphipod end
struct Amber  <: Amphipod end
struct Bronze <: Amphipod end
struct Copper <: Amphipod end
struct Desert <: Amphipod end
struct Empty  <: Amphipod end

const AMPHITYPES = Dict(
    'A' => Amber,
    'B' => Bronze,
    'C' => Copper,
    'D' => Desert
)


abstract type Space end

struct Hallway <: Space
    idx::Int64
end

abstract type Room <: Space end

struct AmberRoom  <: Room idx::Int64 end
struct BronzeRoom <: Room idx::Int64 end
struct CopperRoom <: Room idx::Int64 end
struct DesertRoom <: Room idx::Int64 end

const MaybeAmphipod = Union{Nothing,Amphipod}
const State = Dict{Space,MaybeAmphipod}


# Ingest the Data -------------------------------------------------------------

function ingest(path)
    state = State()
    open(path) do f
        rooms = [
            AmberRoom(1), BronzeRoom(1), CopperRoom(1), DesertRoom(1),
            AmberRoom(2), BronzeRoom(2), CopperRoom(2), DesertRoom(2),
        ]
        for room in rooms
            skipchars(c -> c in "#. \n", f)
            char = read(f, Char)
            amphipod = AMPHITYPES[char]
            state[room] = amphipod()
        end

        for n in 1:11
            hallway = Hallway(n)
            state[hallway] = nothing
        end
    end
    return state
end
