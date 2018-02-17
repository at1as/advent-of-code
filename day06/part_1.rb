memory_blocks = File.open("input.txt", "r").readlines().map { |line| line.split("\t").map(&:strip).map(&:to_i) }.flatten
prior_states = []

puts "Size #{prior_states.length}    #{memory_blocks.dup}"
loop do
  largest_block_val = memory_blocks.max
  largest_block_idx = memory_blocks.index(largest_block_val)


  c = -1
  removed = 0
  memory_blocks.cycle.each_with_index do |block, idx|
    c += 1
    next if c <= largest_block_idx

    memory_blocks[idx % memory_blocks.length] += 1
    memory_blocks[largest_block_idx] -= 1
    removed += 1
     
    break if removed == largest_block_val
  end

  prior_states << memory_blocks.dup
  prior_states.sort!

  break if prior_states.uniq.length != prior_states.length

  puts "Size #{prior_states.length}    #{memory_blocks.dup}"
end

puts prior_states.length
