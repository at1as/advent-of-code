
code = File.open("./code.txt", "r").read.strip.split("").map(&:to_i)
code = code << code[0]

puts code.each_cons(2).reduce(0) { |sum, arr| arr[0] == arr[1] ? sum + arr[0] : sum  }
puts code.each_cons(2).map { |x| x[0] == x[1] ? x[0] : 0 }.reduce(:+)

sum = 0
code.each_with_index do |x, i|
  sum += x if x == code[i+1]
end

puts sum
