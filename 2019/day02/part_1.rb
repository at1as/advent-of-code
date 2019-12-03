input  = File.read("./input.txt").split(",").map(&:strip).map(&:to_i).each_slice(4).to_a
output = File.read("./input.txt").split(",").map(&:strip).map(&:to_i)

input.each do |line|
  operation, in1, in2, out = line

  puts "processing #{operation} #{in1} #{in2} #{out}"

  puts output.join(",")
  if operation == 1
    output[out] = output[in1] + output[in2]
  elsif operation == 2
    output[out] = output[in1] * output[in2]
  elsif operation == 99
    puts "HALTED AT #{output[0]} with full trace: #{output}"
    exit
  else
    puts "ERROR"
    exit
  end
end
