input = File.open("./input.txt", "r").readlines.map(&:strip)

program_map = input.map do |line|
  [
    line.split(" <-> ")[0].to_i,
    line.split(" <-> ")[1].split(", ").map(&:strip).map(&:to_i)
  ]
end.to_h

$active_programs = []

def program(number, program_map)
  connections = program_map[number]
  connections.each do |cnx|
    next if $active_programs.include? cnx
    
    $active_programs << cnx
    program(cnx, program_map)
  end
end

program(0, program_map)
puts $active_programs.length

