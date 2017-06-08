def my_min(arr)
  smallest = true

  arr.each do |elem1|
    smallest = true
    arr.each do |elem2|
      if elem1 > elem2
        smallest = false
      end
    end
    return elem1 if smallest
  end
  smallest
end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min(list)  # =>  -5

def good_min(arr)
  smallest = arr.first

  arr.each do |elem|
    smallest = elem if elem < smallest
  end
  smallest
end

# list = (1..10000000).to_a.shuffle # [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p good_min(list)  # =>  -5

def largest_subsum(list)
  sub_arrays = []
  list.each_index do |first|
    (first...list.length).each do |last|
      sub_arrays << list[first..last]
    end
  end
  sub_arrays.map! { |s| s.inject(:+) }.max
end

# p largest_subsum([2, 3, -6, 7, -6, 7])

def better_subsum(arr)
  largest = nil

  list.each_index do |first|
    (first...list.length).each do |last|
      subsum = arr[first..last].inject(:+)
      largest = subsum if subsum > largest || largest.nil?
    end
  end

  largest
end
