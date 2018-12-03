data = File.open("./input.txt", "r").readlines()

freqs = []
data.map(&:to_i).cycle.inject(0) do |acc, n|
  current_freq = acc + n

  if freqs.include? current_freq
    puts current_freq
    break
  end

  freqs << current_freq
  current_freq
end

