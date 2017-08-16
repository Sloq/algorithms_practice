require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    if @length <= index
      raise "index out of bounds"
    else
      @store[index]
    end
  end

  # O(1)
  def []=(index, value)
    if index < capacity
      @store[index] = value
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def pop
    if @length > 0
      @length -= 1
      @store[@length]
    else
      raise "index out of bounds"
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length < capacity
      @store[@length] = val
      @length += 1
    else
      new_store = StaticArray.new(@capacity * 2)
      (0...@capacity).each do |idx|
        new_store[idx] = @store[idx]
      end
      @store = new_store
      @capacity = @capacity * 2
      @length += 1
      @store[@length] = val
    end
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length > 0
      return_val = @store[0]
      new_store = StaticArray.new(@capacity)
      (1...@length).each do |idx|
        new_store[idx - 1] = @store[idx]
      end
      @store = new_store
      @length -= 1
      return_val
    else
      raise "index out of bounds"
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length == 0
      @store[0] = val
    elsif @length == @capacity
      new_store = StaticArray.new(@capacity * 2)
      new_store[0] = val
      (0...@capacity).each do |idx|
        new_store[idx + 1] = @store[idx]
      end
      @store = new_store
      @capacity = @capacity * 2
    else
      new_store = StaticArray.new(@capacity)
      new_store[0] = val
      (0...@capacity).each do |idx|
        new_store[idx + 1] = @store[idx]
      end
      @store = new_store
    end
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
  end
end
