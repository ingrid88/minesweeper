class Minesweeper
  def initialize
    @board = Array.new(9) { Array.new(9) }
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
