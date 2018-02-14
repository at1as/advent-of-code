code = File.open("./code.txt", "r").read.strip.split("").map(&:to_i)

sum = 0
code.each_with_index { |x, idx| sum += x if x == code[(idx + code.length/2) % code.length] }
puts sum

