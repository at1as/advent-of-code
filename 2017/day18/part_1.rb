input = File.open("./input.txt", "r").readlines().map(&:strip)

input = input.map { |op_reg_amt| op_reg_amt.split }

registers = Hash.new(0)
played = []

def get_numeric(registers, value)
  if ("A".."Z").include? value.upcase
    registers[value].to_i
  else 
    value.to_i
  end
end

idx = 0
loop do
  
  case (instruction = input[idx])[0]
    when "set"
      registers[instruction[1]] = get_numeric(registers, instruction[2])
    when "add"
      registers[instruction[1]] += get_numeric(registers, instruction[2])
    when "mul"
      registers[instruction[1]] *= get_numeric(registers, instruction[2])
    when "mod"
      registers[instruction[1]] %= get_numeric(registers, instruction[2])
    when "snd"
      played << [instruction[1], registers[instruction[1]].to_i]
    when "rcv"
      unless registers[instruction[1]].zero?
        found = played.reverse.find { |reg_name, prior_reg_val| reg_name == instruction[1] && prior_reg_val != 0 }
        
        if found
          puts found
          break
        end
      end
    when "jgz"
      unless registers[instruction[1]].zero?
        idx += get_numeric(registers, instruction[2])
        next
      end
  end

  idx += 1
end
