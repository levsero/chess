# encoding: utf-8
require_relative 'board'
require_relative 'players/computer_player'
require_relative 'players/computer_player2'
require_relative 'players/human_player'

class GameTest
  attr_reader :board, :player1, :player2
  attr_accessor :turn

  def initialize
    @board = Board.new(true)
    get_players
    @turn = @player1
  end

  def play
    puts "test"
    turns = 0
    until board.game_over?(turn.color) || turns == 50
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

  def get_players
    @player1 = ComputerPlayer.new(:white, board)
    @player2 = ComputerPlayer2.new(:black, board)
  end

  def self.compare_comps
    black, white, draw = 0, 0, 0
    10.times do
      game = self.new
      result = game.play
      p result
    end
  end
  nil
end
Game.compare_comps
