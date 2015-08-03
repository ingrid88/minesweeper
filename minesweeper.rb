class Minesweeper
  NUM_BOMBS = 10
  BOARD_SIZE = 9
  attr_reader :board, :mine_positions

  def initialize
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    @mine_positions = add_mines
  end

  def populate_board
    board.each_index do |row|
      board.each_index do |col|
        bombed = false
        bombed = true if mine_positions.include?([row, col])
        board[row][col] = Tile.new(bombed,neighbor_bombs)
      end
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
  attr_accessor :bombed, :flagged, :revealed, :neighbor_bombs
  def initialize(bombed,neighbor_bombs)
    @bombed = bombed
    @flagged = false
    @revealed = false
    @neighbor_bombs = neighbor_bombs
  end

  def to_s
  end

end
