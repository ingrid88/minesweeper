require_relative 'board'

class Minesweeper


  attr_reader :board, :mine_positions

  def initialize
    @board = Board.new
  end

  def reveal(pos)
    return if board[pos].flagged
    board[pos].revealed = true

    if board[pos].num_bombs == 0 && !board[pos].has_bomb
      board.neighbors(pos).each do |n_pos|
        reveal(n_pos) unless (board[n_pos].has_bomb || board[n_pos].revealed)
      end
    end
  end

  def flag_bomb(pos)
    return if board[pos].revealed
    board[pos].flagged = !board[pos].flagged
  end

  def run
    loop do
      board.render
      if has_won?
        puts "You won!"
        break
      elsif board.bomb_revealed?
        puts "You lost!"
        break
      else
        prompt_user
      end
    end
  end

  def prompt_user
    puts "Input position and r/f (reveal or flag)"
    input = gets.chomp.split(",")

    handle_input(input)
  end

  def handle_input(input)
    x,y,opt = input
    x, y = x.to_i, y.to_i
    if board.in_board?([x,y])
      case opt
      when 'r'
        reveal([x,y])
      when 'f'
        flag_bomb([x,y])
      else
        puts "Invalid option"
      end
    else
      puts "Invalid coordinate"
    end
  end

  def has_won?
    !tiles.any? { |tile| !tile.has_bomb && !tile.revealed }
  end

  def tiles
    board.grid.flatten
  end

end


if __FILE__ == $PROGRAM_NAME
  m = Minesweeper.new
  m.run
end
