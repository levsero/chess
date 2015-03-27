# encoding: utf-8
class Pawn < Piece
  attr_reader :value

  def initialize(board, color, pos)
    super(board, color, pos)
    @value = 1;
  end

  def render
    color == :white ? "♙" : "♟"
  end

  def legal_moves
    all_moves.select{ |pos| !move_into_check?(pos)}
  end

  def all_moves # overriding piece method
    modifier = color == :white ? -1 : 1
    legal_moves_array = []

    legal_moves_array << [1 * modifier + pos[0], pos[1]]

    if starting_pos? && @board[[1 * modifier + pos[0], pos[1]]].nil?
      legal_moves_array << [2 * modifier + pos[0], pos[1]]
    end

    # filter for square on the board
    legal_moves_array.select! do |pos|
      board.valid_pos?(pos)
    end

    # only move to nil squares
    legal_moves_array.select!{|legal_pos| board[legal_pos].nil?}


    all_moves = legal_moves_array.concat(attack_moves(modifier))

    # if pos[0] == 7 || pos[0] == 0
    #   all_moves = []
    # end

    all_moves
  end

  def moves # used for checking for check
    modifier = color == :white ? -1 : 1
    attack_moves(modifier)
  end

  def starting_pos?
    if color == :black
      return pos[0] == 1
    else
      return pos[0] == 6
    end
  end

  def attack_moves(modifier)
    attack_moves = []

    attack_moves << [1 * modifier + pos[0], pos[1] + 1]
    attack_moves << [1 * modifier + pos[0], pos[1] - 1]

    attack_moves.select{ |pos| board.valid_pos?(pos) }.select do |pos|
      !board[pos].nil? && board[pos].color != @color
    end
  end

  def move(end_pos)
    super(end_pos)
    if @pos[0] == 7 && color == :black
      board[@pos] = Queen.new(@board, :black, pos)
    elsif @pos[0] == 0 && color == :white
      board[@pos] = Queen.new(@board, :white, pos)
    end
  end

end
