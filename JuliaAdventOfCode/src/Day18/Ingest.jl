# Helper Functions -------------------------------------------------------------

# Get the index of the middle comma in the string representation of a 
# Snailfish number. This is the point to split the string when parsing it
# into a binary tree.
function middleidx(s::AbstractString)
    depth = 0
    for (idx, char) in enumerate(s)
        if char == '['; depth += 1; end
        if char == ']'; depth -= 1; end
        if char == ',' && depth <= 1
            return idx
        end
    end
    return nothing
end


# Data Structures --------------------------------------------------------------

# Store the Snailfish numbers in a binary tree, with the possibility of nodes
# being empty. In reality, they won't be at the end, but in wile building up
# the tree, some of the nodes may be temporarily `nothing` while they're being
# initialized.
abstract type Node end
const MaybeNode = Union{Nothing,Node}


# The `Leaf` nodes contain the numeric values
mutable struct Leaf <: Node
    parent::MaybeNode
    value::Int64
end
Leaf(s::AbstractString) = Leaf(nothing, parse(Int, s))
Leaf(parent::Node, s::AbstractString) = Leaf(parent, parse(Int, s))


# The `Branch` nodes provide the structure, containing a left and right `Node`, 
# either a `Leaf`,  a `Branch`, or possibly `nothing`
mutable struct Branch <: Node
    parent::MaybeNode
    left::MaybeNode
    right::MaybeNode
end
Branch(left::Node, right::Node) = Branch(nothing, left, right)
Branch(::Nothing) = Branch(nothing, nothing, nothing)
Branch(parent::Node) = Branch(parent, nothing, nothing)

function Branch(s::AbstractString, parent = nothing)
    all(isnumeric, s) && return Leaf(parent, s)

    middle = middleidx(s)
    (leftstr, rightstr) = (s[2:middle-1], s[middle+1:end-1])
    newbranch = Branch(parent)
    newbranch.left  = Branch(leftstr,  newbranch)
    newbranch.right = Branch(rightstr, newbranch)
    return newbranch
end


# A `Tree` is the binary tree, just contains the root `Branch`
struct Tree
    root::Node
end

function Tree(s::AbstractString)
    root = Branch(s)
    return Tree(root)
end


# Ingest the Data ==============================================================

function ingest(path)
    return open(path) do f
        [Tree(line) for line in readlines(f)]
    end
end

