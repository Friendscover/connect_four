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
    check_columns(player.icon) ? true : false
  end

  def check_columns(icon)
    board.board.each_with_index do |array, array_index|
      array.each_with_index do |position, position_index|
        if position == icon
          coins_column = []
          coins_row = []
          i = array_index
          j = position_index

          #checks the next 4 elements in a column; compare in array
          4.times do
            coins_column << board.board[i][position_index]
            i += 1 
            break if i > 5
          end

          #checks the next 4 elements in a row
          4.times do
            coins_row << board.board[array_index][j]
            j += 1 
            break if j > 6
          end

          if coins_column.join == icon * 4
            return true
          elsif coins_row.join == icon * 4
            return true
          end
        end
      end
    end
    false
  end

  def print_board
    board.board.each do |elements|
      p elements
    end
  end
end
