require_relative 'player'
require_relative 'game_turn'
require_relative 'treasure_trove'
require 'csv'

class Game

  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(a_player)
    @players.push(a_player)
  end

  def load_players(from_file)
    CSV.foreach(from_file) do |row|
      player = Player.new(row[0], row[1].to_i)
      add_player(player)
    end
  end

  def play(rounds)

    treasures = TreasureTrove::TREASURES
    puts "\nThere are #{treasures.size} treasures to be found:"
    treasures.each do |treasure|
      puts "A #{treasure.name} is worth #{treasure.points} points"
    end

    puts "\nThere are #{@players.size} players in #{@title}: "

    @players.each do | player |
      puts player
    end
      
    1.upto(rounds) do |round|
      if block_given?
        break if yield
      end
      puts "\nRound #{round}:"
      @players.each do | player |
        GameTurn.take_turn(player)
        puts player
      end
    end
  end 

  def print_player_name_and_health(player)
    puts "#{player.name} (#{player.health})"
  end

  def total_points
    @players.reduce(0) { |sum, player| sum + player.points }
  end

  def high_score_entry(player)
    formatted_name = player.name.ljust(20, '.')
    "#{formatted_name} #{player.score}"
  end

  def print_stats
    strong_players = @players.select { |player| player.strong? } 
    wimpy_players = @players.reject { |player| player.strong? }

    puts "\n#{@title} Statistics:"

    puts "\n#{strong_players.size} strong players:"
      strong_players.each do |player|
      print print_player_name_and_health(player)
    end

    puts "\n#{wimpy_players.size} wimpy players:"
    wimpy_players.each do |player|
      print print_player_name_and_health(player)
    end
    
    puts "\n#{@title} High Scores:"
      @players.sort.each do |player|
        puts high_score_entry(player)
      end

    @players.sort.each do |player|
      puts "\n#{player.name}'s points totals:"
      player.each_found_treasure do |treasure|
        puts "#{treasure.points} total #{treasure.name} points"
      end
      puts "#{player.points} grand total points"
    end

    puts "\n#{total_points} points from treasures found!"
  end

  def save_high_scores(filename="high_scores.txt")
    File.open(filename, "w") do |file|
      file.puts "#{title} High Scores:"
      @players.sort.each do |player|
        file.puts high_score_entry(player) 
      end
    end
  end
end

