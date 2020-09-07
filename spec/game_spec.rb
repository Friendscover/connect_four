require "./lib/game.rb"

describe "connect_four" do
  before { @game = Game.new }

  context "creation" do
    let(:player1) { @game.player1 }

    it "creates player and game_board" do
      expect(@game.board).to be_a GameBoard
      expect(@game.player1).to be_a Coin
      expect(@game.player2).to be_a Coin
    end

    it "sets position of player1 on board" do 
      @game.set_position(player1, 0)
      expect(@game.board.board[5][0]).to eq("☾")
    end

    it "set position of player on board if no position is given" do 
      2.times { @game.set_position(player1) }
      expect(@game.board.board[4][0]).to eq("☾")
    end

    it "set position of player1 on top of placed coins" do
      3.times { @game.set_position(player1, 0) }
      expect(@game.board.board[3][0]).to eq("☾")
    end

    it "fails to place a coin out of bounce" do
      6.times { @game.set_position(player1, 0) }
      expect(@game.set_position(@game.player1)).to eq(false)
    end
  end

  context "game_over" do
    let(:player1) { @game.player1 }

    it "when one player has four coins in a column" do
      4.times { @game.set_position(player1) }
      expect(@game.check_winner(player1)).to eq(true)
    end

    it "when one player has four coins in another column" do
      2.times { @game.set_position(player1) }
      4.times { @game.set_position(@game.player2) }
      expect(@game.check_winner(@game.player2)).to eq(true)
    end

    it "when one player has four coins in a row" do
      i = 0
      while i < 4
        @game.set_position(player1, i)
        i += 1
      end
      expect(@game.check_winner(player1)).to eq(true)
    end

    it "when one player has a right diagonal row" do
      @game.set_position(player1, 0)
      2.times { @game.set_position(player1, 1) }
      3.times { @game.set_position(player1, 2) }
      3.times { @game.set_position(@game.player2, 3) }
      @game.set_position(player1, 3)
      expect(@game.check_winner(player1)).to eq(true)
    end

    it "when one player has a left diagonal row" do
      @game.set_position(player1, 4)
      2.times { @game.set_position(player1, 3) }
      3.times { @game.set_position(player1, 2) }
      3.times { @game.set_position(@game.player2, 1) }
      @game.set_position(player1, 1)
      expect(@game.check_winner(player1)).to eq(true)
    end
  end
end