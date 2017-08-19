class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
    @my_proc = prc
  end

  def count
    @store.length
  end

  def extract
    raise "heap is empty" if count == 0
    value = @store[0]
    if count > 1
      @store[0] = @store.pop
      BinaryMinHeap.heapify_down(@store, 0, &@prc)
    else
      @store.pop
    end
    value
  end

  def peek
    raise "heap is empty" if count == 0
    @store[0]
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, count-1, count, &@my_prc)
    val
  end

  public
  def self.child_indices(len, parent_index)
    children = []
    first_child_idx = parent_index * 2 + 1
    second_child_idx = parent_index * 2 + 2
    if first_child_idx < len
      children << first_child_idx
    end
    if second_child_idx < len
      children << second_child_idx
    end
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index-1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    p array
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    kids = child_indices(len, parent_idx)
    if kids.length == 1
      best_child = kids[0]
    else
      best_child = prc.call(array[kids[0]], array[kids[1]]) <= 0 ? kids[0] : kids[1]
    end
    while best_child && prc.call(array[parent_idx], array[best_child]) > 0
      array[parent_idx], array[best_child] = array[best_child], array[parent_idx]
      parent_idx = best_child
      kids = child_indices(len, parent_idx)
      p "kids"
      p kids
      if kids.empty?
        return array
      elsif kids.length > 1
        best_child = prc.call(array[kids[0]], array[kids[1]]) <= 0 ? kids[0] : kids[1]
      else
        best_child = kids[0]
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if child_idx == 0
    parent_idx = self.parent_index(child_idx)

    if prc.call(array[parent_idx], array[child_idx]) > 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      self.heapify_up(array, parent_idx, len, &prc)
    else
      return array
    end
  end
end

min_proc = Proc.new {|a, b| a <=> b ? 1 : -1 }
max_proc = Proc.new {|a, b| b <=> a ? 1 : -1 }
