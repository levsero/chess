# encoding: utf-8
require_relative 'board'
require_relative 'players'

class Game
  attr_reader :board, :player1, :player2
  attr_accessor :turn

  def initialize
    @board = Board.new(true)
    get_players
    @turn = @player1
    nil
  end

  def get_players
    puts "Player 1 human?(y/n)"
    p1 = gets.chomp.downcase

    puts "Player 2 human?(y/n)"
    p2 = gets.chomp.downcase

    create_players(p1, p2)
  end

  def create_players(p1, p2)
    if p1 == "y"
      @player1 = HumanPlayer.new(:white)
    else
      @player1 = ComputerPlayer.new(:white, board)
    end
    if p2 == "y"
      @player2 = HumanPlayer.new(:black)
    else
      @player2 = ComputerPlayer2.new(:black, board)
    end
  end

  def play
    puts "Let's play chess!"
    until board.game_over?(turn.color)

      puts board.display_board
      begin
        puts "#{turn.color}'s move:"
        move = turn.get_move

        board.move(move[0], move[1], turn.color)

      rescue ArgumentError => e
        puts e
        raise e
      retry
      end
      toggle_turn
    end

    puts board.display_board
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
end

g = Game.new
g.play
