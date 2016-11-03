require_relative 'player'

class Game

  def initialize(title)
    @title = title
    @players = []
  end

  attr_reader :title
  attr_accessor :players

  def add_player(a_player)
    @players.push(a_player)
  end

  def play
    puts "There are #{players.size} players in #{@title}: "
    @players.each do | p |
      puts p 
    end
    @players.each do | p |
      p.blam
      p.w00t
      p.w00t
      puts p
    end
  end
end

