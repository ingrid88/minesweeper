class Minesweeper
  NUM_BOMBS = 10
  BOARD_SIZE = 9

  def initialize
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end

  def populate_board
    

  end
end

class Tile
  attr_accessor :bombed, :flagged, :revealed
  def initialize(bombed)
    @bombed = bombed
    @flagged = false
    @revealed = false
  end
end
