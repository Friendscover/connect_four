require_relative "game_board"
require_relative "coin.rb"

class Game 
  attr_accessor :board, :player1, :player2, :current_player

  def initialize
    @board = GameBoard.new
    @player1 = Coin.new("Moon")
    @player2 = Coin.new("Star", "★")
    @current_player = @player2
  end

  def play
   until check_winner(current_player)
    toggle_player
    user_input = get_input
    set_position(current_player, user_input)
    print_board
   end

   print_winner
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
    if board.board[0][position] == " "
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
      break if marker == " "
    end
    
    return height
  end

  def get_input
    puts "#{current_player.name} it's your turn! Choose a position between 1 and 7"
    input = gets.chomp
    until input.to_i > 0 && input.to_i < 8
      puts "This is a wrong position. Choose again!"
      input = gets.chomp
    end
    #substracts 1 to not got out of bounds of the game
    return input.to_i - 1
  end

  def toggle_player
    @current_player == player1 ? @current_player = player2 : @current_player = player1
  end

  def check_winner(player)
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

          if coins_column.join == icon * 4 || coins_row.join == icon * 4 || coins_diagonal_right.join == icon * 4 || coins_diagonal_left.join == icon * 4
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
      p elements.join(" | ")
    end
  end

  def print_winner
    puts "The Winner is #{current_player.name}!"
    puts "Congratz! You are talented!"
  end
end

g = Game.new
g.play