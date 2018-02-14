data = File.open("./input.txt", "r").readlines()

data_matrix = data.map { |row| row.split.map(&:to_i) }

divisors = data_matrix.map do |row|
  row.permutation(2).find { |pair| pair[0] % pair[1] == 0 }
end

puts divisors.map { |x| x[0]/x[1] }.reduce(:+)
