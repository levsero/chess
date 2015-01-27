class SteppingPiece < Piece
  def initialize(board, color, pos, symbol)
    super(board, color, pos, symbol)
  end

  def pos_moves
    @pos_moves = self.class::DELTAS.map do |delta|
      [delta[0] + pos[0], delta[1] + pos[1]]
    end.select do |pos|
      pos[0].between?(0,7) && pos[1].between?(0,7)
    end
  end

  def legal_moves
    legal_moves_array = pos_moves.select do |pos|
      board[pos].nil? || board[pos].color != color
    end.select {|pos| !move_into_check?(pos) }
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
