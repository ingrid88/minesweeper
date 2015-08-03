require_relative 'tile'

class Board
  attr_reader :grid, :mine_positions
  NEIGHBORS_DELTAS = [[-1,-1],[-1,0],[-1,1],[0,1],[1,0],[1,1],[1,-1],[0,-1]]
  NUM_BOMBS = 10
  BOARD_HEIGHT = 9
  BOARD_WIDTH = 9

  def initialize
    @grid = Array.new(BOARD_HEIGHT) { Array.new(BOARD_WIDTH) }
    @mine_positions = generate_mine_positions
    populate_board
  end

  def num_neighbor_bombs(pos)
    num_bombs = 0
    neighbors(pos).each do |n_pos|
      num_bombs += 1 if mine_positions.include?(n_pos)
    end
    num_bombs
  end

  def neighbors(pos)
    x, y = pos
    new_pos_list = []
    NEIGHBORS_DELTAS.each do |change|
      dx,dy = change
      new_pos_list << [x + dx, y + dy]
    end
    new_pos_list.select{ |pos| in_board?(pos) }
  end

  def in_board?(pos)
    pos.all? { |coord| coord.between?(0,8) }
  end

  def generate_mine_positions
    mine_positions = []
    until mine_positions.length == NUM_BOMBS
      rand_x = rand(0...BOARD_HEIGHT)
      rand_y = rand(0...BOARD_WIDTH)
      mine_positions << [rand_x, rand_y] if !mine_positions.include?([rand_x, rand_y])
    end
    mine_positions
  end

  def render
    system('clear')
    grid.each do |row|
      row.each do |tile|
        print tile.to_s
      end
      print "\n"
    end
  end

  def populate_board
    grid.each_index do |row|
      grid.each_index do |col|
        has_bomb = false
        has_bomb = true if mine_positions.include?([row, col])
        grid[row][col] = Tile.new(has_bomb, num_neighbor_bombs([row,col]))
      end
    end
  end

  def bomb_revealed?
    mine_positions.any? {|bomb| self[bomb].revealed}
  end

  def [](pos)
    x,y = pos
    grid[x][y]
  end

  # def []=(pos, value)
  #   x,y = pos
  #   grid[x][y] = value
  # end

end
