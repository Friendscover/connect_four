require "./lib/game.rb"

describe "game" do
  before { @game = Game.new }

  context "creation" do
    it "creates player and game_board" do
      expect(@game.board).to be_a GameBoard
      expect(@game.player1).to be_a Coin
      expect(@game.player2).to be_a Coin
    end

    it "sets position of player1 on board" do 
      @game.set_position(@game.player1, 0)
      expect(@game.board.board[5][0]).to eq("☾")
    end

    # it "set position of player on board if no position is given" do 
    #   @game.set_position(@game.player1)
    #   expect(@game.board.board[4][0]).to eq("☾")
    # end

    # it "set position of player1 on top of placed coins" do
    #   @game.set_position(@game.player1, 0)
    #   expect(@game.board.board[4][0]).to eq("☾")
    end
  end
end