require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    if index >= @length
      raise "index out of bounds"
    else
      @store[(@start_idx + index) % capacity]
    end
  end

  # O(1)
  def []=(index, val)
    @store[(@start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    if @length > 0
      @length -= 1
      @store[(start_idx + @length) % @capacity]
    else
      raise "index out of bounds"
    end
  end

  # O(1) ammortized
  def push(val)
    resize! if @capacity == @length
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    if @length > 0
      return_val = @store[@start_idx]
      @store[@start_idx] = nil
      @start_idx = (@start_idx + 1) % @capacity
      @length -= 1
      return_val
    else
      raise "index out of bounds"
    end
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    (0...@capacity).each do |idx|
      new_store[idx] = @store[(@start_idx + idx) % @capacity]
    end
    @start_idx = 0
    @store = new_store
    @capacity = @capacity * 2
  end
end
