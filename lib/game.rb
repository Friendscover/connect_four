#checks if won
#how the fuck does the game see won?
#creates player + board
# => player returns player
#loops the game
class Game 
  attr_accessor :board, :player1, :player2, :current_player

  def initialize
    @board = GameBoard.new
    @player1 = Coin.new
    @player2 = Coin.new("coin2", "★")
    @current_player = @player1
  end

  def set_position(player, position = 0)
    if full_column?(position)
      return false
    else
      height = get_height(position)
      board.board[height][position] = player.icon  
    end
  end

  def full_column?(position)
    if board.board[0][position] == ""
      false
    else
      true
    end
  end

  def get_height(position)
    height = 6
    marker = nil

    loop do 
      height -= 1
      marker = board.board[height][position]
      break if marker == ""
    end
    
    return height
  end

  def check_winner(player)
    print_board
    check_position(player.icon) ? true : false
  end

  def check_position(icon)
    board.board.each_with_index do |array, array_index|
      array.each_with_index do |position, position_index|
        if position == icon
          coins_column = check_column(array_index, position_index)

          coins_row = check_row(array_index, position_index)

          coins_diagonal_right = check_diagonal_right(array_index, position_index)

          coins_diagonal_left = check_diagonal_left(array_index, position_index)

          if coins_column.join == icon * 4
            return true
          elsif coins_row.join == icon * 4
            return true
          elsif coins_diagonal_right.join == icon * 4
            return true
          elsif coins_diagonal_left.join == icon * 4
            return true
          end
        end
      end
    end
    false
  end

  def check_column(array_index, position_index)
    coins_column = []
    i = array_index

    #checks the next 4 elements in a column; compare in array
    4.times do 
      coins_column << board.board[i][position_index]
      i += 1
      break if i > 5
    end

    return coins_column
  end

  def check_row(array_index, position_index)
    coins_row = []
    i = position_index

    #checks the next 4 elements in a row
    4.times do
      coins_row << board.board[array_index][i]
      i += 1 
      break if i > 6
    end
    
    return coins_row
  end

  def check_diagonal_right(array_index, position_index) 
    coins_diagonal = []
    i = 0

    4.times do 
      #break if the diagonal right is out of bounds 
      break if (array_index + i) > 5 || (position_index - i) < 0
      
      coins_diagonal << board.board[array_index + i][position_index - i]
      i += 1
    end

    return coins_diagonal
  end

  def check_diagonal_left(array_index, position_index)
    coins_diagonal = []
    i = 0

    4.times do
      #breaks if the values are out of bounds
      break if (array_index - i) < 0 || (position_index + i) < 0

      coins_diagonal << board.board[array_index - i][position_index - i]
      i += 1
    end
    return coins_diagonal
  end

  def print_board
    board.board.each do |elements|
      p elements
    end
  end
end

p g = Game.new