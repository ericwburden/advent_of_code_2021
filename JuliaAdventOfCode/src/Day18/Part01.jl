# Helper Functions =============================================================

# Helper functions for splitting a value according to the puzzle rules,
# rounding one half down and one half up.
splitleft(value)::Int = floor(value / 2)
splitright(value)::Int = ceil(value / 2)
splitvalue(value) = (splitleft(value), splitright(value))


# Binary Tree Functions ========================================================

# Leaf -------------------------------------------------------------------------

# Functions to allow add-assign operations for `Leaf` values.
function add!(a::Leaf, b::Leaf) 
    a.value += b.value
end
function add!(a::Leaf, b::Int64) 
    a.value += b
end


# Node (Leaf/Branch) -----------------------------------------------------------

# Recursively traverse a binary tree structure starting with a given
# node, printing the values and depths of leaf nodes when they are found.
# Useful for debugging!
function traverse(node::Node, depth = 0)
    if node isa Leaf
        println("($(node.value), $depth)")
        return nothing
    end
    traverse(node.left, depth + 1)
    traverse(node.right, depth + 1)
end

# Given a node in the binary tree, recursively search for the leftmost leaf
function firstleaf(node::Node)
    node isa Leaf && return node
    return firstleaf(node.left)
end

# Given a node in the binary tree, recursively search for the rightmost leaf
function lastleaf(node::Node)
    node isa Leaf && return node
    return lastleaf(node.right)
end

# Given a node in the binary tree, recursively search for the rightmost leaf 
# that occurs prior to the current node. Return `nothing` if there are no `Leaf`
# nodes to the left of the current node.
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

# Given a node in the binary tree, recursively search for the leftmost leaf
# that occurs after the current node. Return `nothing` if there are no `Leaf`
# nodes to the right of the current node.
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

# Recursively search starting at a give node for a `Node` with a depth of 4.
# This will find the leftmost node that can be 'exploded' first. 
function explosivenode(node::Node, depth = 0)
    node isa Leaf && return nothing
    depth == 4 && return node
    left = explosivenode(node.left, depth + 1)
    isnothing(left) && return explosivenode(node.right, depth + 1)
    return left
end

# 'Explode' a node that has two `Leaf`s as its children, adding the value of its
# left leaf to the rightmost leaf that occurs prior to the exploding node and 
# adding the value of its right leaf to the leftmost leaf that occurs after the
# exploding node (basically what the puzzle instructions say).
function explode!(node::Node)
    (parent, left, right) = (node.parent, node.left.value, node.right.value)

    # Add the left value to the previous leaf
    previous = previousleaf(node)
    if !isnothing(previous)
        add!(previous, left)
    end

    # Add the right value to the subsequent leaf
    next = nextleaf(node)
    if !isnothing(next)
        add!(next, right)
    end

    # The `Leaf` left after exploding needs to go into the same 'slot'
    # as the exploded Node.
    if parent.left == node
        parent.left = Leaf(parent, 0)
    else
        parent.right = Leaf(parent, 0)
    end
end

# Recursively search starting at a given node for a 'Leaf' with a value greater
# than `9`, indicating it needs to be split. This search will find the leftmost
# `Leaf` that can be split. Return `nothing` if there are no `Leaf`s that can
# be split.
function splitnode(node::Node)
    if node isa Leaf 
        node.value > 9 && return node
        return nothing
    end

    # Search down the left side of the current node
    left = splitnode(node.left)
    left isa Leaf && return left

    # If nothing is found down the left side, search down the right side
    # of the current node
    right = splitnode(node.right)
    right isa Leaf && return right
    
    # If nothing is found on either side, return `nothing`
    return nothing
end

# Split a `Leaf` node, replacing it with a `Branch` whose children have the split
# value of the previous `Leaf`.
function split!(leaf::Leaf)
    (leftval, rightval) = splitvalue(leaf.value)
    splitnode = Branch(leaf.parent)
    splitnode.left  = Leaf(splitnode, leftval)
    splitnode.right = Leaf(splitnode, rightval)

    # The new `Node` needs to go into the same 'slot' as the `Leaf`
    # that was split up.
    if leaf.parent.left == leaf
        leaf.parent.left = splitnode
    else
        leaf.parent.right = splitnode
    end
end

# Recursively calculate the magnitude of a tree, starting at a given node.
function magnitude(node::Node)
    node isa Leaf && return node.value
    left = magnitude(node.left) * 3
    right = magnitude(node.right) * 2
    return left + right
end


# Tree -------------------------------------------------------------------------

# Combine two trees, adding each of their root nodes as the children of a 
# new root node.
function combine(a::Tree, b::Tree)
    root = Branch(nothing)
    
    root.left = a.root
    root.left.parent = root

    root.right = b.root
    root.right.parent = root

    return Tree(root)
end

# Overload the `+` operator to combine two trees and `simplify!()` (what the 
# puzzle description calls 'reducing') the new tree.
function Base.:+(a::Tree, b::Tree)
    tree = combine(a, b)
    simplify!(tree)
    return tree
end

# Convenience method to call `traverse()` on a tree, for debugging.
traverse(tree::Tree) = traverse(tree.root)

# If there is a pair of values nested 4 or more deep, explode that pair and
# return true. Otherwise, return false.
function explode!(tree::Tree)
    explosive = explosivenode(tree.root)
    isnothing(explosive) && return false
    explode!(explosive)
    return true
end

# If there is a `Leaf` with a value greater than 9, split that `Leaf` into a 
# new `Branch` and return true. Otherwise, return false.
function split!(tree::Tree)
    splitat = splitnode(tree.root)
    isnothing(splitat) && return false
    split!(splitat)
    return true
end

# Simplify (reduce) a snailfish number represented by a `Tree`. Repeatedly 
# searches for nodes to explode, then explodes them. If there are no nodes to
# explode, search for a `Leaf` to split and split it. Stops when there are
# no nodes that need to be exploded or split.
function simplify!(tree::Tree)
    while true
        explode!(tree) && continue
        split!(tree)   && continue
        break
    end
end

# Convenience method to calculate the magnitude of a `Tree`
magnitude(tree::Tree) = magnitude(tree.root)


# Solve Part One ===============================================================

# Take the input, then sum all the snailfish numbers. Because we overloaded the 
# `+` operator, we can just use the `sum()` method to perform an add-reduce over
# the list of `Tree`s from the input. Finally, we return the magnitude of the
# resulting `Tree`.
function part1(input)
    input = deepcopy(input)
    finalnumber = sum(input)
    return magnitude(finalnumber)
end