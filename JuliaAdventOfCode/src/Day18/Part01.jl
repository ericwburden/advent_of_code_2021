# Helper Functions =============================================================

splitleft(value)::Int = floor(value / 2)
splitright(value)::Int = ceil(value / 2)
splitvalue(value) = (splitleft(value), splitright(value))


# Binary Tree Functions ========================================================

# Leaf -------------------------------------------------------------------------

function add!(a::Leaf, b::Leaf) 
    a.value += b.value
end
function add!(a::Leaf, b::Int64) 
    a.value += b
end


# Node (Leaf/Branch) -----------------------------------------------------------

function traverse(node::Node, depth = 0)
    if node isa Leaf
        println("($(node.value), $depth)")
        return nothing
    end
    traverse(node.left, depth + 1)
    traverse(node.right, depth + 1)
end

function firstleaf(node::Node)
    node isa Leaf && return node
    return firstleaf(node.left)
end

function lastleaf(node::Node)
    node isa Leaf && return node
    return lastleaf(node.right)
end

function previousleaf(node::Node)
    # If we hit the root node, there is no previous leaf
    isnothing(node.parent) && return nothing

    if node.parent.left == node
        # If this is the left node, travel up the tree one level and check for
        # a previous value starting at the parent node.
        return previousleaf(node.parent)
    else
        # If it's not the left node, then start searching for the rightmost
        # leaf starting with this node's left sibling.
        return lastleaf(node.parent.left)
    end
end

function nextleaf(node::Node)
    # If we hit the root node, there is no previous leaf
    isnothing(node.parent) && return nothing

    if node.parent.right == node
        # If this is the right node, travel up the tree one level and check for 
        # a next value starting at the parent node.
        return nextleaf(node.parent)
    else
        # If it's not the right node, then start searching for the leftmost
        # leaf starting with this node's right sibling
        return firstleaf(node.parent.right)
    end
end

# Find the first node with a depth equal to 4
function explosivenode(node::Node, depth = 0)
    node isa Leaf && return nothing
    depth == 4 && return node
    left = explosivenode(node.left, depth + 1)
    isnothing(left) && return explosivenode(node.right, depth + 1)
    return left
end

function explode!(node::Node)
    (parent, left, right) = (node.parent, node.left.value, node.right.value)

    previous = previousleaf(node)
    if !isnothing(previous)
        add!(previous, left)
    end

    next = nextleaf(node)
    if !isnothing(next)
        add!(next, right)
    end

    if parent.left == node
        parent.left = Leaf(parent, 0)
    else
        parent.right = Leaf(parent, 0)
    end
end

function splitnode(node::Node)
    if node isa Leaf 
        node.value > 9 && return node
        return nothing
    end


    left = splitnode(node.left)
    left isa Leaf && return left

    right = splitnode(node.right)
    right isa Leaf && return right
    
    return nothing
end

function split!(leaf::Leaf)
    (leftval, rightval) = splitvalue(leaf.value)
    splitnode = Branch(leaf.parent)
    splitnode.left  = Leaf(splitnode, leftval)
    splitnode.right = Leaf(splitnode, rightval)

    if leaf.parent.left == leaf
        leaf.parent.left = splitnode
    else
        leaf.parent.right = splitnode
    end
end

function magnitude(node::Node)
    node isa Leaf && return node.value
    left = magnitude(node.left) * 3
    right = magnitude(node.right) * 2
    return left + right
end


# Tree -------------------------------------------------------------------------

function combine(a::Tree, b::Tree)
    root = Branch(nothing)
    
    root.left = a.root
    root.left.parent = root

    root.right = b.root
    root.right.parent = root

    return Tree(root)
end

function Base.:+(a::Tree, b::Tree)
    tree = combine(a, b)
    simplify!(tree)
    return tree
end

traverse(tree::Tree) = traverse(tree.root)

# If there is a pair of values nested 4 or more deep, explode that pair and
# return true. Otherwise, return false.
function explode!(tree::Tree)
    explosive = explosivenode(tree.root)
    isnothing(explosive) && return false
    explode!(explosive)
    return true
end

function split!(tree::Tree)
    splitat = splitnode(tree.root)
    isnothing(splitat) && return false
    split!(splitat)
    return true
end

function simplify!(tree::Tree)
    while true
        explode!(tree) && continue
        split!(tree)   && continue
        break
    end
end

magnitude(tree::Tree) = magnitude(tree.root)


# Solve Part One ===============================================================

function part1(input)
    input = deepcopy(input)
    finalnumber = sum(input)
    return magnitude(finalnumber)
end