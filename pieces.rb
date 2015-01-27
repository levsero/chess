class Piece
  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @moves = []
  end

end

class Pawn < Piece

  def initialize(board, color, pos)
    super(board, color, pos)
  end

  def legal_moves
    modifier = color == :black ? -1 : 1
    legal_moves_arr = []

    legal_moves_arr << [1 * modifier + pos[0], pos[1]]

    if starting_pos?
      legal_moves_arr << [2 * modifier + pos[0], pos[1]]
    end

    legal_moves_arr += attack_moves

  end

  def starting_pos?
    if color == :black
      return pos[0] == 1
    else
      return pos[0] == 6
    end
  end

  def attack_moves
    attack_moves = []

    attack_moves << [1 * modifier + pos[0], pos[1] + 1]
    attack_moves << [1 * modifier + pos[0], pos[1] - 1]

    attack_moves.select!{ |pos| board[pos].any? && board[pos].color != color }
  end

end
