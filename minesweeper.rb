class Minesweeper
  NUM_BOMBS = 10
  BOARD_SIZE = 9
  NEIGHBORS_DELTAS = [[-1,-1],[-1,0],[-1,1],[0,1],[1,0],[1,1],[1,-1],[0,-1]]
  attr_reader :board, :mine_positions

  def initialize
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    populate_board
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

  def reveal(pos)
    # if position has a bomb the user loses firstly
    return if self[pos].flagged
    raise "you lose" if self[pos].has_bomb
    # if the number of bombs is greater than zero then set revealed = true
    #self[pos].revealed = true if self[pos].num_bombs > 0
    # if # bombs is 0 then look at neighbors
    self[pos].revealed = true
    if self[pos].num_bombs == 0
      #figure out neighbor
      neighbors(pos).each do |n_pos|
        reveal(n_pos) unless (self[n_pos].has_bomb || self[n_pos].revealed)
      end
    end
    #nil
  end

  def render
    board.each do |row|
      row.each do |tile|
        print tile.to_s
      end
      print "\n"
    end
  end

  def flag_bomb(pos)
    return if self[pos].revealed
    self[pos].flagged = !self[pos].flagged
  end

  def run
    until has_won?
      prompt_user
      render
    end
    puts "You won!"
  end

  def prompt_user
    puts "Input position and r/f (reveal or flag)"
    input = gets.chomp
    handle_input(input)
  end

  def handle_input(input)
    coord, opt = input

  end

  def has_won?
    # all unbombed tiles revealed

    # if revealed and if not bombed
    flattened = board.flatten
    !flattened.any?{ |tile| !tile.has_bomb && !tile.revealed}
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
    return "F " if flagged
    return "* " if !revealed
    if revealed && num_bombs > 0
      return "#{num_bombs} "
    else
      "_ "
    end
  end

end


if __FILE__ == $PROGRAM_NAME

  m = Minesweeper.new
  m.run

end
