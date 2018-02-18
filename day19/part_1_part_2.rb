class Solver
  attr_reader :visited_nodes, :steps
  
  def initialize(debug: true)
    @input   = File.open("./input.txt", "r").readlines().map { |x| x.gsub(/\n$/, "").split("") }
    @width   = @input.first.length
    @height  = @input.length
    @idx_x   = 0
    @idx_y   = 0
    @steps   = 0
    @debug   = true
    @direction = :down
    @visited_nodes = []
  end

  def next_node
    next_value = @input[@idx_y][@idx_x]

    puts "WORKING WITH #{next_value} @ #{@direction} (#{@idx_x+1}, #{@idx_y+1})" if @debug

    if next_value == " "
      @direction = :done
      return
    end

    @steps += 1
    @visited_nodes << next_value if ('A'..'Z').include? next_value

    case @direction
      when :down
        if next_value == "+"
          if @input[@idx_y][@idx_x+1] != " "
            @direction = :right
            @idx_x += 1
          else
            @direction = :left
            @idx_x -= 1
          end
        else
          @idx_y += 1
        end
      
      when :up
        if next_value == "+"
          if @input[@idx_y][@idx_x+1] != " "
            @direction = :right
            @idx_x += 1
          else
            @direction = :left
            @idx_x -= 1
          end
        else
          @idx_y -= 1
        end
      
      when :left
        if next_value == "+"
          if @input[@idx_y+1][@idx_x] != " "
            @direction = :down
            @idx_y += 1
          else
            @direction = :up
            @idx_y -= 1
          end
        else
          @idx_x -= 1
        end
      
      when :right
        if next_value == "+"
          if @input[@idx_y+1][@idx_x] != " "
            @direction = :down
            @idx_y += 1
          else
            @direction = :up
            @idx_y -= 1
          end
        else
          @idx_x += 1
        end
    end
  end

  def solve
    while @direction != :done
      prior = @input[@idx_y][@idx_x]
      next_node
    end
  end

  def find_start_node
    while @input[@idx_y][@idx_x] == " "
      @idx_x += 1
    end
  end
end

solution = Solver.new
solution.find_start_node
solution.solve

puts solution.visited_nodes.join
puts solution.steps
