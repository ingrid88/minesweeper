class Minesweeper
  NUM_BOMBS = 10
  BOARD_SIZE = 9
  attr_reader :board

  def initialize
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end

  def populate_board
    board.each_index do |row|
      board.each_index do |col|
        board[row][col] = Tile.new
      end
    end

  end
end

class Tile
  attr_accessor :bombed, :flagged, :revealed
  def initialize
    @bombed = false
    @flagged = false
    @revealed = false
  end
end
