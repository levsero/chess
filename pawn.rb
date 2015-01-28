class Pawn < Piece

  def initialize(board, color, pos, symbol)
    super(board, color, pos, symbol)
  end

  def legal_moves # overriding piece method
    modifier = color == :white ? -1 : 1
    legal_moves_array = []

    legal_moves_array << [1 * modifier + pos[0], pos[1]]

    if starting_pos?
      legal_moves_array << [2 * modifier + pos[0], pos[1]]
    end

    legal_moves_array.concat(attack_moves(modifier)).select do |pos|
      !move_into_check?(pos)
    end
  end

  def pos_moves # used for checking for check
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

    attack_moves.select{ |pos| !board[pos].nil? && board[pos].color != color }
  end
end
