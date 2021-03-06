input = File.open("./input.txt", "r").readlines.map(&:strip)

registers = {}
input.map(&:split).map(&:first).uniq.each { |i| registers[i] = 0 }

input.each do |instruction|
  # hwv inc 149 if clj >= -5
  r, diff, quantity, clause = instruction.split(" ", 4)

  if diff == "inc"
    eval("registers['#{r}'] += #{quantity} if registers['#{clause.split(' ', 3)[1]}'] #{clause.split(' ', 3)[2]}") 
  else
    eval("registers['#{r}'] -= #{quantity} if registers['#{clause.split(' ', 3)[1]}'] #{clause.split(' ', 3)[2]}") 
  end
end

puts registers.max_by { |k, v| v }
