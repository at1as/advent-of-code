input = File.open("./input.txt", "r").readlines.map(&:to_i)

idx = 0
steps = 0

loop do
  old_idx = idx
  idx = old_idx + input[old_idx]
  input[old_idx] += 1
  steps += 1
  break if input[idx].nil?
end

puts steps
