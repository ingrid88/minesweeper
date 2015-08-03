class Minesweeper
  NUM_BOMBS = 10
  BOARD_SIZE = 9
  attr_reader :board

  def initialize
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end

  def populate_board
    mine_positions = add_mines
    board.each_index do |row|
      board.each_index do |col|
        bombed = false
        bombed = true if mine_positions.include?([row, col])
        board[row][col] = Tile.new(bombed)
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
  attr_accessor :bombed, :flagged, :revealed
  def initialize(bombed)
    @bombed = bombed
    @flagged = false
    @revealed = false
  end

  def to_s
  end

end
