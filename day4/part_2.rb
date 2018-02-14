input = File.open("./input.txt", "r").readlines

x = input.map(&:strip).select do |row|
  row.split.length == row.split.uniq.length &&
    row.split.map { |word| word.split("").sort }.length == row.split.map { |word| word.split("").sort }.uniq.length
end.length

puts x


