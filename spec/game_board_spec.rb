require "./lib/game_board"

describe "creates game_board" do
  it "with empty positions" do
    game_board = GameBoard.new
  end

  it "with a 6x7 array" do
    game_board = GameBoard.new
    expect(game_board.create_board).not_to eq(nil)
  end
end

