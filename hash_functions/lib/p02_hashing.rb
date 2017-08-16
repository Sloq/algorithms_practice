class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return_num = 1337909
    self.each_with_index do |num, idx|
      flatter = 1
      while num.is_a?(Array)
        num = num[0]
        flatter *= 12
      end
      if flatter > 1
        return_num = return_num * flatter
      else
        return_num = return_num * num**idx
      end
    end
    return_num.hash
  end
end

class String
  def hash
    letters = self.chars
    letters.map!(&:ord)
    letters.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    return_num = 133790969
    arr = self.to_a.flatten
    arr.each_with_index do |val|
      num_val = val.to_s.ord
      return_num = return_num * num_val
    end
    return_num.hash
  end
end
