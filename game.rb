require_relative 'player'
require_relative 'game_turn'

class Game

  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(a_player)
    @players.push(a_player)
  end

  def play(rounds)
    puts "There are #{@players.size} players in #{@title}: "

    @players.each do | player |
      puts player
    end
      
    1.upto(rounds) do |round|
      puts "\nRound #{round}:"
      @players.each do | player |
        GameTurn.take_turn(player)
        puts player
      end
    end
  end 

  def print_stats
    strong_players = @players.select { |player| player.strong? } 
    wimpy_players = @players.reject { |player| player.strong? }

    puts "\n#{@title} Statistics:"

    puts "\n#{strong_players.size} strong players:"
    strong_players.each do |player|
      puts "#{player.name} (#{player.health})"
    end

    puts "\n#{wimpy_players.size} wimpy players:"
    wimpy_players.each do |player|
      puts "#{player.name} (#{player.health})"
    end

    sorted_players = @players.sort { |a, b| b.score <=> a.score }
    
    puts "\n#{@title} High Scores:"
    sorted_players.each do |player|
      formatted_name = player.name.ljust(20, '.')
      puts "#{formatted_name} #{player.score}"
    end
  end
end

