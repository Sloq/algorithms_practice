require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    if !self.include?(num)
      self[num].push(num)
      @count += 1
      if @count+1 == num_buckets
        resize!
      end
      return true
    end
    false
  end

  def include?(key)
    num = key.hash
    self[num].include?(num)
  end

  def remove(key)
    num = key.hash
    if self.include?(key)
      self[num].delete(num)
      @count -= 1
      return true
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |val|
        new_store[val % (num_buckets * 2)].push(val)
      end
    end
    @store = new_store
  end
end
