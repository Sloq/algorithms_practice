require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  letters = string.chars
  unmatched_count = 0
  map = HashMap.new(letters.count)
  letters.each do |ltr|
    if map.include?(ltr)
      unmatched_count -= 1
    else
      unmatched_count += 1
    end
    map.set(ltr, true)
  end
  return false if unmatched_count > 1
  true
end
