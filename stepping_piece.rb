class SteppingPiece < Piece
  def initialize(board, color, pos)
    super(board, color, pos)
  end

  def pos_moves
    @pos_moves = DELTAS.map do |delta|
      [delta[0] + pos[0], delta[1] + pos[1]]
    end
  end

  def legal_moves
    @legal_moves = pos_moves.filter do |pos|
      next if board[pos].nil?
      board[pos].color == color
    end
  end
end

class King < SteppingPiece
  DELTAS = [[-1, -1], [-1, 0], [-1, 1],
             [0, -1],           [0, 1],
             [1, -1], [1, 0],   [1, 1]]


end

class Knight < SteppingPiece


  DELTAS = [[-1, -2], [-2, -1], [-2, 1],
             [1, -2],           [2, -1],
             [-1, 2], [1, 2],   [2, 1]]

end
