
def kth_largest(tree_node, k)
  i = k
  while i > 0
    max = tree_node.maximum
    tree_node.delete(max.value)
    i -= 1
  end
  tree_node.maximum.value
end
