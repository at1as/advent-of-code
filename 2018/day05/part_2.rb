input_chars = File.open("./input.txt", "r").readlines().map(&:strip).first.split("")

### Working, albiet slow solution. This can easily be improved ###

def remove_duplicates(char_array)
  #
  # Given an array of chars ["A", "b", "c", "C", "D", "E", "F"]
  #
  # Will an array with adjoining lower-case<->capital pairs removed
  #
  #  "["A", "b", "c", "C", "D", "E", "F"] => ["A", "b", "D", "E", "F"]
  #
  # Note that this will compare idx=0 <=> idx=1 , idx=2 <=> idx=3, ..
  # It will not compare idx=1 to idx=2
  #
  # As such, this function should be called twice, once with first character offset
  # See `remove_all_duplicates` for implementation
  #
  char_array.each_slice(2).reject { |x| 
    /[[:upper:]]/.match(x.first) ? x.first.downcase == x.last : x.first.upcase == x.last
  }.flatten
end

def remove_all_duplicates(char_array)
  #
  # `remove_duplicates` function above operates on every pair segment
  # for example, ["b", "a", "A", "c"] => [["b", "a"], ["A", "c"]]
  #
  # This method will call it twice, once to reject :
  #     [["b", "a"], ["A", "c"]]
  #
  # And once again to compare pairs with an offset of one:
  #     ["b"] + [["a", "A"], ["c', ..."], ...]
  #
  # There are clearly better ways to do this
  #
  cleaned_char_array = remove_duplicates(char_array)

  [cleaned_char_array.first] + remove_duplicates(cleaned_char_array[1..-1])
end

def reduce_polymer_chain(char_input)
  #
  # Return fully reduced polymer chain, recursively removing adjoining lowercase<=>capital pairs
  #
  #      ["A", "B", "b", "a", "c", "B"]
  #  #=> ["A", "a", "c", "B"]
  #  #=> [c", "B"]
  #
  if (cleaned_input = remove_all_duplicates(char_input)) != char_input
    reduce_polymer_chain(cleaned_input)
  else
    char_input
  end
end

def remove_letter_and_reduce(char_input, letter)
  #
  # Remove one character entirely from the polymer chain (lower case and capitals), and then reduce
  #
  reduce_polymer_chain(char_input.reject { |c| [letter.upcase, letter.downcase].include? c }).length
end

def find_shortest_polymer_chain(char_input, characters_to_remove)
  #
  # Return shortest resulting polymer chain length after attempting to remove each character
  #
  best_combo = char_input.length

  characters_to_remove.each do |c|
    str_len = remove_letter_and_reduce(char_input, c)
    puts "for chracter #{c} the resulting polymer was #{str_len} characters (compared with #{best_combo})"
    best_combo = str_len if str_len < best_combo
  end

  best_combo
end


reacted_polymer_chain = reduce_polymer_chain(input_chars)
remaining_chars = reacted_polymer_chain.map(&:downcase).uniq
puts "Part 1: Reacted chain length: " + reacted_polymer_chain.length.to_s

# => 9202

shortest_polymer_length = find_shortest_polymer_chain(reacted_polymer_chain, remaining_chars)
puts "Part 2: Shortest length: " + shortest_polymer_length.to_s

# => 6394

