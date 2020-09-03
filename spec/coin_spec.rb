require "./lib/coin.rb"

describe "creates coin" do 
  before { @coin = Coin.new("#{name}", "#{icon}") }

  context "parameters" do
    let(:name) { "player1" }
    let(:icon) { "★" }
    
    it "creates a coin without parameters" do
      expect(@coin).to_not eq(nil)
    end

    it "with name player1 " do
      expect(@coin.name).to eq(name)
    end

    it "with icon ★" do 
      expect(@coin.icon).to eq("★")
    end
  end
end