# encoding: utf-8
require_relative 'chess_board'

class Game
  attr_reader :board, :player1, :player2
  attr_accessor :turn

  def initialize
    @board = Board.new(true)
    get_players
    @turn = @player1
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
      @player2 = ComputerPlayer.new(:black, board)
    end
  end

  def play
    puts "Let's play chess!"
    until board.game_over?(turn.color)

      board.display_board
      begin
        puts "#{turn.color}'s move:"
        move = turn.get_move

        board.move(move[0], move[1], turn.color)

      rescue ArgumentError => e
        puts e
      retry
      end
      toggle_turn
    end

    board.display_board
    check_result
  end

  def toggle_turn
    @turn = @turn == @player1 ? @player2 : @player1
  end

  def check_result
    if board.check_mate?(turn.color)
      toggle_turn
      puts "#{turn.color} wins!"
    else
      puts "Stalemate!"
    end
  end

end

class HumanPlayer
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def get_move
    puts"Choose Piece:(e.g. E2)"
    piece = gets.chomp
    piece = convert_input(piece)

    puts"Choose Move:(e.g. E4)"
    move = gets.chomp
    move = convert_input(move)

    [piece, move]
  end

  def convert_input(input)
    input = input.split("")

    input[0], input[1] = 8 - input[1].to_i, input[0].downcase.ord - 97

    input
  end
end

class ComputerPlayer
  attr_accessor :color

  def initialize(color, board)
    @board = board
    @color = color
  end

  def get_move
    return find_checkmate unless find_checkmate.nil?

    piece = select_random_piece
    move = select_random_move(piece)

    [piece.pos, move]
  end

  def select_random_piece
    @board.pieces(:color => @color).select{|piece| piece.legal_moves.any?}.sample
  end

  def select_random_move(piece)
    piece.legal_moves.sample
  end

  def find_checkmate
    @board.pieces(:color => color).each do |piece|
      piece.legal_moves.each do |end_move|

        dupe = @board.dup

        dupe[piece.pos].move(end_move)

        opp_color = color == :white ? :black : :white
        return [piece.pos, end_move] if dupe.check_mate?(opp_color)
      end
    end
    nil
  end
end
