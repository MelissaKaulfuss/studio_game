require_relative 'game'
require 'ostruct'

describe Game do

  before do
    @game = Game.new("Knuckleheads")

    @initial_health = 100
    @player = Player.new("moe", @initial_health)

    @game.add_player(@player)
  end

  it "has a title" do
    expect(@game.title).to eq("Knuckleheads")
  end

  it "w00ts the player if a high number is rolled" do
    mock_die = OpenStruct.new(roll: 5)
    allow(Die).to receive(:new).and_return(mock_die)
    
    @game.play

    expect(@player.health).to eq(@initial_health + 15)
  end

  it "doesn't affect a players health if a medium number is rolled" do
    mock_die = OpenStruct.new(roll: 3)
    allow(Die).to receive(:new).and_return(mock_die)
    
    @game.play

    expect(@player.health).to eq(@initial_health)
  end

  it "blams a player if a low number is rolled" do
    mock_die = OpenStruct.new(roll: 1)
    allow(Die).to receive(:new).and_return(mock_die)
    
    @game.play

    expect(@player.health).to eq(@initial_health - 10)
  end

end
