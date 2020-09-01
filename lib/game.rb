#checks if won
#how the fuck does the game see won?
#creates player + board
# => player returns player
#loops the game
class Game 
  attr_accessor :board, :player1, :player2

  def initialize
    @board = GameBoard.new
    @player1 = Coin.new
    @player2 = Coin.new
  end

  def set_position(player, position = 0)
    height = get_height(position)
    board.board[height][position] = player.icon
    print_board
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

  def print_board
    board.board.each do |elements|
      p elements
    end
  end
end
