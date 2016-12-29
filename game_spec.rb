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
    
    @game.play(2)

    expect(@player.health).to eq(@initial_health + 15 * 2)
  end

  it "doesn't affect a players health if a medium number is rolled" do
    mock_die = OpenStruct.new(roll: 3)
    allow(Die).to receive(:new).and_return(mock_die)
    
    @game.play(2)

    expect(@player.health).to eq(@initial_health)
  end

  it "blams a player if a low number is rolled" do
    mock_die = OpenStruct.new(roll: 1)
    allow(Die).to receive(:new).and_return(mock_die)
    
    @game.play(2)

    expect(@player.health).to eq(@initial_health - 10 * 2)
  end

  it "assigns a treasure for points during a player's turn" do
    game = Game.new("Knuckleheads")
    player = Player.new("moe")

    game.add_player(player)

    game.play(1)

    expect(player.points).not_to be_zero
  end

  it "computes total points as the sum of all player points" do
    game = Game.new("Knuckleheads")
    player1 = Player.new("moe")
    player2 = Player.new("larry")

    game.add_player(player1)
    game.add_player(player2)

    player1.found_treasure(Treasure.new(:hammer, 50))
    player1.found_treasure(Treasure.new(:hammer, 50))
    player2.found_treasure(Treasure.new(:crowbar, 400))

    expect(game.total_points).to eq(500)
  end

end
