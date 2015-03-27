# encoding: utf-8
require_relative 'board'
require_relative 'players'

class GameTest
  attr_reader :board, :player1, :player2
  attr_accessor :turn

  def initialize
    @board = Board.new(true)
    get_players
    @turn = @player1
  end

  def get_players
    @player1 = ComputerPlayer.new(:white, board)
    @player2 = ComputerPlayer2.new(:black, board)
  end

  def play
    puts "test"
    turns = 0
    until board.game_over?(turn.color) || turns == 70
      begin
        move = turn.get_move
        board.move(move[0], move[1], turn.color)

      rescue ArgumentError => e
        puts e
        raise e
      retry
      end
      toggle_turn
      turns += 1
    end
    check_result
  end

  def toggle_turn
    @turn = @turn == @player1 ? @player2 : @player1
  end

  def check_result
    if board.check_mate?(turn.color)
      toggle_turn
      puts "#{turn.color} wins!"
      return turn.color
    else
      puts "Stalemate!"
      return "draw"
    end
  end

  def self.compare_comps(num)
    results = Hash.new(0)
    num.times do
      game = self.new
      result = game.play
      results[result] += 1
    end
    p results
  end
end
GameTest.compare_comps(ARGV[0].to_i)
