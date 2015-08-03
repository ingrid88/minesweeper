class Minesweeper
  NUM_BOMBS = 10
  BOARD_SIZE = 9
  NEIGHBORS_DELTAS = [[-1,-1],[-1,0],[-1,1],[0,1],[1,0],[1,1],[1,-1],[0,-1]]
  attr_reader :board, :mine_positions

  def initialize
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    @mine_positions = add_mines
  end

  def populate_board
    board.each_index do |row|
      board.each_index do |col|
        has_bomb = false
        has_bomb = true if mine_positions.include?([row, col])
        board[row][col] = Tile.new(has_bomb, num_neighbor_bombs([row,col]))
      end
    end

  end

  def [](pos)
    x,y = pos
    @board[x][y]
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
    new_pos_list.select do |pos|
      pos.all? {|coord| coord.between?(0,8)}
    end
  end


  def add_mines
    mine_positions = []
    until mine_positions.length == NUM_BOMBS
      rand_x = rand(0...BOARD_SIZE)
      rand_y = rand(0...BOARD_SIZE)
      mine_positions << [rand_x, rand_y] if !mine_positions.include?([rand_x, rand_y])
    end
    mine_positions
  end

  def render
    board.each do |row|
      row.each do |tile|
        print tile.to_s
      end
      print "\n"
    end
  end


end

class Tile
  attr_accessor :flagged, :revealed
  attr_reader :num_bombs, :has_bomb

  def initialize(has_bomb, num_bombs)
    @has_bomb = has_bomb
    @flagged = false
    @revealed = false
    @num_bombs = num_bombs
  end

  def to_s
    #if revealed and if num_bombs > 0 then print num_bombs value
    # if not revealed print *
    # if revealed and if num_bombs = 0 then print __
    # if flagged then print F
    return "F" if flagged
    return "*" if !revealed
    if revealed && num_bombs > 0
      return num_bombs
    else
      "_"
    end
  end

end
