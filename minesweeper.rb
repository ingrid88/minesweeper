require_relative 'board'
require 'yaml'

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
    puts "Input position and r/f (reveal or flag), or 's' to save game"
    input = gets.chomp.split(",")
    handle_input(input)
  end

  def handle_input(input)
    if input == ['s']
      save_game
      puts "Your game was saved."
      sleep(1)
      return
    end
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
        sleep(1)
      end
    else
      puts "Invalid coordinate"
      sleep(1)
    end
  end

  def has_won?
    !tiles.any? { |tile| !tile.has_bomb && !tile.revealed }
  end

  def tiles
    board.grid.flatten
  end

  def save_game
    saved_game = self.to_yaml
    #write file and store in local directory
    file_name = 'saved_game.txt'
    File.open(file_name, 'w') { |file| file.write(saved_game) }
  end

end


if __FILE__ == $PROGRAM_NAME
  if ARGV.length > 0
    # convert the file into a minesweeper object
    game_save = File.read(ARGV.shift)
    m = YAML.load(game_save)
    puts m
  else
    m = Minesweeper.new()
  end
  m.run
end
