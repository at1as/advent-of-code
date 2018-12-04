data = File.open("./input.txt", "r").readlines()

coordinates = data.map do |line|
  coords = line.split.map { |x| x.gsub(/:\Z/, "") }.map { |x| x.split(/,|x/) }.flatten

  {
		id:		 coords[0],
    x_min: coords[2].to_i,
    y_min: coords[3].to_i,
    x_max: coords[2].to_i + coords[4].to_i,
    y_max: coords[3].to_i + coords[5].to_i
  }
end

unique_position = nil
coordinates.each_with_index do |c1, c1_idx|

  # Presumably using `any` makes this better than an n^2 search
  # since `any` should return as soon as a match is found
  matched = coordinates.each_with_index.any? do |c2, c2_idx|
    c1_idx != c2_idx && 
      c1[:x_min] <= c2[:x_max] &&
      c1[:x_max] >  c2[:x_min] &&
      c1[:y_min] <= c2[:y_max] &&
      c1[:y_max] >  c2[:y_min]
  end

  (unique_position = c1[:id] ; break) unless matched
end

puts unique_position.to_s

