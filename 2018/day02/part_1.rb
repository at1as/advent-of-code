data = File.open("./input.txt", "r").readlines()

triples = data.select { |x| x.strip.split("").group_by { |x| x }.any? { |_k, v| v.length == 3 } }.length
doubles = data.select { |x| x.strip.split("").group_by { |x| x }.any? { |_k, v| v.length == 2 } }.length

puts triples * doubles

