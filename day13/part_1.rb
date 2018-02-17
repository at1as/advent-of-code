input = File.open('./input.txt', 'r').readlines.map(&:strip).map { |x| [*x.split(": ").map(&:to_i)] }

firewall = input.map { |x| [x[0], Array.new(x[1]) { |_| "." }] }
firewall = firewall.map { |x| [x[0], ["X"] + x[1][1..-1]] }.to_h

def tick(firewall, idx)
  firewall.map do |x|
    [
      x[0],
      (idx % (x[1].length * 2 - 2)) < (x[1].length - 1) ? x[1].rotate(-1) : x[1].rotate(1)
    ]
  end.to_h 
end


hits = []
(0..firewall.keys.max).each do |s|
  unless firewall[s]
    firewall = tick(firewall, s)
    next
  end

  if firewall[s][0] == "X"
    hits << firewall[s].length * s
  end
  
  puts "TICK::#{s}   #{firewall[s]}"
  firewall = tick(firewall, s)
end

puts "#{hits}"
puts "#{hits.reduce(:+)}"
