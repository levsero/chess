class Pawn < Piece

  def initialize(board, color, pos, symbol)
    super(board, color, pos, symbol)
  end

  def legal_moves
    modifier = color == :white ? -1 : 1
    legal_moves_arr = []

    legal_moves_arr << [1 * modifier + pos[0], pos[1]]

    if starting_pos?
      legal_moves_arr << [2 * modifier + pos[0], pos[1]]
    end

    legal_moves_arr.concat(attack_moves(modifier))
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
