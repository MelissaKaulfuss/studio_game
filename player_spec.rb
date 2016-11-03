require_relative 'player'

describe Player do 
  it "has a capitalized name" do
    player = Player.new("larry", 150)

    expect(player.name).to eq("Larry")
  end

end