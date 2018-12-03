data = File.open("./input.txt", "r").readlines()

puts data.map(&:to_i).inject(:+)
