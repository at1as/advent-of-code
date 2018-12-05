input = File.open("./input.txt", "r").readlines().map(&:strip).first

#
# Working, albiet slow solution. This can easily be improved
#

def remove_duplicates(txt)
  txt.split("").each_slice(2).reject { |x| 
    /[[:upper:]]/.match(x.first) ? x.first.downcase == x.last : x.first.upcase == x.last
  }.join("")
end

def react_polymer_chain(raw_input)

  if (condensed_input = remove_duplicates(raw_input)) != raw_input
    react_polymer_chain(condensed_input)
  else
    shifted_condensed_input = raw_input.split("").first + remove_duplicates(raw_input[1..-1])
    shifted_condensed_input != raw_input ? react_polymer_chain(shifted_condensed_input) : raw_input.length
  end

end

puts react_polymer_chain(input)
#=> 9202

