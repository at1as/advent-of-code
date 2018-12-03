data = File.open("./input.txt", "r").readlines().sort

data.reduce("") do |acc, n| 
  false_matches = acc.split("").each_with_index.reject { |x, idx| n.split("")[idx] == x }

  if false_matches.length == 1
    puts acc.split("").each_with_index.select { |x, idx| n.split("")[idx] == x }.map(&:first).join("")
    break
  end

  n
end


