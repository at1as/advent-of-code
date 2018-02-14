data = File.open("./input.txt", "r").readlines()

data_matrix = data.map(&:strip).map { |x| x.split.map(&:to_i) }
puts data_matrix.map { |row| row.max - row.min }.reduce(:+)
