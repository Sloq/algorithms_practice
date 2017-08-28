# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_helper(@root, value, nil)
  end

  def find(value, tree_node = @root)
    return nil unless tree_node
    return tree_node if value == tree_node.value
    if value < tree_node.value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    tree_node = find(value)
    return nil unless tree_node
    if !tree_node.left && !tree_node.right
      delete_helper(tree_node, nil)
    elsif !tree_node.right
      delete_helper(tree_node, tree_node.left)
    elsif !tree_node.left
      delete_helper(tree_node, tree_node.right)
    else
      max_left_leaf = maximum(tree_node.left)
      if max_left_leaf.left
        max_left_leaf.parent.right = max_left_leaf.left
      end
      delete_helper(tree_node, max_left_leaf)
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return nil unless tree_node
    return tree_node unless tree_node.right
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 if !tree_node
    if tree_node.left || tree_node.right
      return 1 + [depth(tree_node.left), depth(tree_node.right)].max
    else
      return 0
    end
  end

  def is_balanced?(tree_node = @root)
    return true if !tree_node
    if depth(tree_node.left) == depth(tree_node.right) &&
      is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
      return true
    end
    false
  end

  def in_order_traversal(tree_node = @root, arr = [])
    viewed_nodes = []
    current_node = tree_node
    new_arr = arr
    while true
      if current_node
        viewed_nodes << current_node
        current_node = current_node.left
      else
        return new_arr if viewed_nodes.empty?
        node = viewed_nodes.pop
        new_arr << node.value
        current_node = node.right
      end
    end
  end




  private
  # optional helper methods go here:
  def insert_helper(tree_node, val, parent)
    if !tree_node
      tree_node = BSTNode.new(val, parent)
    elsif val < tree_node.value
      tree_node.left = insert_helper(tree_node.left, val, tree_node)
    else
      tree_node.right = insert_helper(tree_node.right, val, tree_node)
    end
    tree_node
  end

  def delete_helper(node, next_node)

    if node.parent
      if node.value < node.parent.value
        node.parent.left = next_node
      else
        node.parent.right = next_node
      end
      next_node.parent = node.parent if next_node
      node.parent = nil
    else
      @root = next_node
    end

    if next_node
      next_node.left = node.left
      next_node.right = node.right
    end

  end

end
