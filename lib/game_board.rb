#gameboard has position of coins
#set position of coin
#return board
class GameBoard
  attr_accessor :board
  
  def initialize
    @board = create_board
  end 
  
  def create_board
    Array.new(6) { Array.new(7, " ") }
  end
end
