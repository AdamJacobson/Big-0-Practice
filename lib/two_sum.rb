# n ^ 2
def bad_two_sum?(arr, target_sum)
  (0...arr.length - 1).each do |first|
    (first + 1..arr.length - 1).each do |last|
      return true if arr[first] + arr[last] == target_sum
    end
  end
  false
end

# n log n
def okay_two_sum?(arr, target_sum)
  arr.sort!
  first = 0
  last = arr.length - 1

  until last <= first
    if arr[first] + arr[last] == target_sum
      return true
    elsif arr[first] + arr[last] < target_sum
      first += 1
    else
      last -= 1
    end
  end
  false
end

# n
def good_two_sum?(arr, target_sum)
  count = Hash.new(0)

  arr.each do |elem|
    return true if count[target_sum-elem] > 0
    count[elem] += 1
  end
  false
end

arr = [0, 1, 7, 5]
p good_two_sum?(arr, 6) # => should be true
p good_two_sum?(arr, 10) # => should be false
