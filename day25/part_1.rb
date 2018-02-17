input = File.open('./input.txt', 'r').readlines.map(&:strip)

state = %w[ A B C D E ].cycle
idx = 0
checksum = [0]

steps = input.find { |x| x.match /Perform a diagnostic checksum after (.*) steps./ }.split(/[^0-9]/).reject(&:empty?).first.to_i

def instruction(state, input, current_value)
  section = -1
  value, direction, next_state = nil
  input.each_with_index do |line, idx|
    if line.strip == "In state #{state}:"
      section = idx
      
      if current_value == 0
        offset = 2
      else
        offset = 6
      end
      
      value      = input[idx+offset].strip.match(/[\s]* .* ([0-9]).$/)[-1].to_i
      direction  = input[idx+offset+1].strip.match(/.* ([A-Za-z]+).$/)[-1] == "left" ? -1 : 1
      next_state = input[idx+offset+2].strip.match(/.* ([A-Z]).$/)[-1]

      break
    end
  end

  [value, direction, next_state]
end

current_state = state.next
steps.times do |step|
  value, direction, next_state = instruction(current_state, input, checksum[idx])

  checksum[idx] = value

  idx += direction
  if idx < 0
    checksum = [0] + checksum
    idx = 0
  elsif idx >= checksum.length
    checksum = checksum + [0]
  end

  current_state = next_state
end

puts checksum.reduce(:+)

