# https://adventofcode.com/2017/day/3

inpt = 289326
dirs = [:right, :up, :left, :down].cycle
mtx  = [[1]]

net_delta_y = 0
net_delta_x = 0

row_idx = 0
col_idx = 0
i       = 1

(puts "1"; exit) if inpt < 2 # will run forever, otherwise

def expand_matrix(matrix, dir)
  empty_row = matrix.first.map { |x| nil }
  case dir
    when :up
      [empty_row] + matrix
    when :down
      matrix + [empty_row]
    when :left
      matrix.map { |r| [nil] + r }
    when :right
      matrix.map { |r| r + [nil] }
    end
end

def fill_in_matrix(row, col, magnitude, matrix, target, delta_x, delta_y)
  matrix[row][col] = magnitude
  (puts "Input of #{target} found with position Δx = #{delta_x} Δy = #{delta_y} Δ = #{delta_x.abs + delta_y.abs}"; exit) if magnitude == target
end

loop do
  row_size = mtx.length
  col_size = mtx[0].length

  case dirs.next
  when :right
    while col_idx < col_size
      col_idx += 1
      net_delta_x += 1
      i += 1
      mtx = expand_matrix(mtx, :right) if col_idx == col_size
      fill_in_matrix(row_idx, col_idx, i, mtx, inpt, net_delta_x, net_delta_y)
    end

  when :up
    while row_idx > 0
      row_idx -= 1 #if row_idx > 0
      net_delta_y -= 1
      i += 1
      fill_in_matrix(row_idx, col_idx, i, mtx, inpt, net_delta_x, net_delta_y)
    end

    mtx = expand_matrix(mtx, :up)
    net_delta_y -= 1
    i += 1
    fill_in_matrix(row_idx, col_idx, i, mtx, inpt, net_delta_x, net_delta_y)

  when :left
    while col_idx > 0
      col_idx -= 1
      net_delta_x -= 1
      i += 1
      fill_in_matrix(row_idx, col_idx, i, mtx, inpt, net_delta_x, net_delta_y)
    end
    i += 1
    net_delta_x -= 1
    mtx = expand_matrix(mtx, :left)
    fill_in_matrix(row_idx, col_idx, i, mtx, inpt, net_delta_x, net_delta_y)

  when :down
    while row_idx < row_size
      row_idx += 1
      net_delta_y += 1
      i += 1
      mtx = expand_matrix(mtx, :down) if row_idx == row_size
      fill_in_matrix(row_idx, col_idx, i, mtx, inpt, net_delta_x, net_delta_y)
    end
  end

end


