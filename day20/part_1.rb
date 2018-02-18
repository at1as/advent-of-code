coords   = Struct.new(:x, :y, :z)
distance = Hash.new(0)

input = File.open("./input.txt", "r").readlines().map(&:strip).map do |line|
  matches = line.gsub(" ", "").match /p=<(-?[0-9]*),(-?[0-9]*),(-?[0-9]*)>,v=<(-?[0-9]*),(-?[0-9]*),(-?[0-9]*)>,a=<(-?[0-9]*),(-?[0-9]*),(-?[0-9]*)>/
  [
    coords.new(matches[1].to_i, matches[2].to_i, matches[3].to_i),   # Position
    coords.new(matches[4].to_i, matches[5].to_i, matches[6].to_i),   # Velocity
    coords.new(matches[7].to_i, matches[8].to_i, matches[9].to_i)    # Acceleration
  ]
end

def manhattan_distance(position)
  position.x.abs + position.y.abs + position.z.abs
end

def tick(input, coord_struct)
  input.map do |particle|
    [
      coord_struct.new(
        particle[0].x + particle[1].x,
        particle[0].y + particle[1].y,
        particle[0].z + particle[1].z
      ),
      coord_struct.new(
        particle[1].x + particle[2].x,
        particle[1].y + particle[2].y,
        particle[1].z + particle[2].z
      ),
      particle[2] # No change to Acceleration
    ]
  end
end

1000.times do
  input = tick(input, coords)
  input.each_with_index do |particle, idx|
    distance[idx] += manhattan_distance(particle[0])
  end
end

puts distance.sort_by { |k, v| v }[0..10].to_s
