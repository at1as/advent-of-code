data = File.open("./input.txt", "r").readlines()

coordinates = data.map do |line|
  coords = line.split.map { |x| x.gsub(/:\Z/, "") }.map { |x| x.split(/,|x/) }.flatten

  {
    x_min: coords[2].to_i,
    y_min: coords[3].to_i,
    x_max: coords[2].to_i + coords[4].to_i,
    y_max: coords[3].to_i + coords[5].to_i
  }
end
#coordinates.each { |x| puts x  }
x_min = coordinates.map { |x| x[:x_min].to_i }.min
x_max = coordinates.map { |x| x[:x_max].to_i }.min
y_min = coordinates.map { |x| x[:y_min].to_i }.min
y_max = coordinates.map { |x| x[:y_max].to_i }.min

overlapping_squares = 0
(x_min.upto(x_max)).each do |x_idx|
  (y_min.upto(y_max)).each do |y_idx|
    puts "(#{x_idx}, #{y_idx}) -> xmin: #{}"
    overlapping_squares += 1 if coordinates.any? { |c| 
      c[:x_min] <= x_idx &&
      c[:x_max] >= x_idx &&
      c[:y_min] <= y_idx &&
      c[:y_max] >= y_idx 
    }
  end
end
puts overlapping_squares
