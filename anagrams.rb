# n!
def first_anagram(first, second)
  all_anagrams = first.chars.permutation
  all_anagrams.include? second.chars
end

# p first_anagram("cats", "tacs")

def second_anagram(first, second)
  return false if first.length != second.length

  first_chars = first.chars
  second_chars = second.chars

  first_chars.each do |f|
    idx = second_chars.index(f)
    second_chars.delete_at(idx) unless idx.nil?
  end

  second_chars.empty?
end

# p second_anagram("dog", "god")

def third_anagram(first, second)
  first.chars.sort == second.chars.sort
end

def fourth_anagram(first, second)
  first_chars = Hash.new(0)

  first.chars.each do |c|
    first_chars[c] += 1
  end

  second.chars.each do |c|
    first_chars[c] -= 1
  end

  first_chars.all? { |k, v| v == 0 }
end

p fourth_anagram("cats", "tacs")
p fourth_anagram("cats", "dogs")
p fourth_anagram("cats", "s")
