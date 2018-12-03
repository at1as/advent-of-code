input = File.open("./input.txt", "r").readlines.map(&:strip)

program_map = input.map do |line|
  [
    line.split(" <-> ")[0].to_i,
    line.split(" <-> ")[1].split(", ").map(&:strip).map(&:to_i)
  ]
end.to_h

$all_programs = program_map.keys

def program(number, program_map)
  connections = program_map[number]
  connections.each do |cnx|
    next if $active_programs.include? cnx
    
    $active_programs << cnx
    program(cnx, program_map)
  end
end

groups = 0
while $all_programs.length > 0
  $active_programs = [$all_programs.first]
  program($all_programs.first, program_map)

  $all_programs -= $active_programs
  groups += 1
end

# Part 2
puts groups
