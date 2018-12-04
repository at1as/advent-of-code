data = File.open("./input.txt", "r").readlines()

#
# Working solution. However, solution is very slow
#

coordinates = data.map do |line|
  coords = line.split.map { |x| x.gsub(/:\Z/, "") }.map { |x| x.split(/,|x/) }.flatten

  {
    x_min: coords[2].to_i,
    y_min: coords[3].to_i,
    x_max: coords[2].to_i + coords[4].to_i,
    y_max: coords[3].to_i + coords[5].to_i
  }
end

x_min = coordinates.map { |c| c[:x_min].to_i }.min
x_max = coordinates.map { |c| c[:x_max].to_i }.max
y_min = coordinates.map { |c| c[:y_min].to_i }.min
y_max = coordinates.map { |c| c[:y_max].to_i }.max

overlapping_squares = 0

(x_min.upto(x_max)).each do |x_idx|
  (y_min.upto(y_max)).each do |y_idx|
    overlapping_squares += 1 if coordinates.select { |c| 
      c[:x_min] <= x_idx &&
      c[:x_max] > x_idx  &&
      c[:y_min] <= y_idx &&
      c[:y_max] > y_idx 
    }.length >= 2
  end
end

puts overlapping_squares

