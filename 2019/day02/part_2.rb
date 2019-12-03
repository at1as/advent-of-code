TARGET = 19690720

1.upto 100 do |x|
  1.upto 100 do |y|
    
    input       = File.read("./input.txt").split(",").map(&:strip).map(&:to_i).each_slice(4).to_a
    input[0][1] = x
    input[0][2] = y 

    output      = File.read("./input.txt").split(",").map(&:strip).map(&:to_i)
    output[1]   = x
    output[2]   = y

    puts "Trying (#{x}, #{y})"

    input.each do |line|
      operation, in1, in2, out = line

      if operation == 1
        output[out] = output[in1] + output[in2]
      elsif operation == 2
        output[out] = output[in1] * output[in2]
      elsif operation == 99
        puts "HALTED AT #{output[0]} with value #{(x * 100) + y}"
        exit if output[0] == TARGET
        next
      else
        puts "ERROR"
        next 
      end
    end

  end
end
