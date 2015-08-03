require 'colorize'

class Tile
  attr_accessor :flagged, :revealed
  attr_reader :num_bombs, :has_bomb

  NUM_COLORS = {
    1 => :blue,
    2 => :green,
    3 => :red,
    4 => :dark_blue,
    5 => :brown,
    6 => :teal,
    7 => :black,
    8 => :grey
  }

  def initialize(has_bomb, num_bombs)
    @has_bomb = has_bomb
    @flagged = false
    @revealed = false
    @num_bombs = num_bombs
  end

  def to_s
    return "F " if flagged
    return "* " if !revealed
    if revealed && has_bomb
      return "X "
    elsif revealed && num_bombs > 0
      return "#{num_bombs} "
    else
      "_ "
    end
  end

end
