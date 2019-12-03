def adder(i, sum)
  n = (i/ 3) - 2
  return n <= 0 ? sum : adder(n, sum + n)
end

puts File.readlines("./input.txt")
        .map(&:strip)
        .map(&:to_i)
        .map { |x| adder(x, 0) }
        .reduce(0, :+)
