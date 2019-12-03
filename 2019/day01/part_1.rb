puts File.readlines("./input.txt")
        .map(&:strip)
        .map(&:to_i)
        .map { |x| (x / 3) - 2 }
        .reduce(0, :+)
