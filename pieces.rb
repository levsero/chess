class Piece

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @moves = []
  end

  def moves
    # possible_moves is a method that returns array of possible moves
      moves = possible_moves


      moves = moves.select{}
  end
end

class SlidingPiece << Piece
  # Bishop, Queen, Rook
  def initialize(*directions) # :rows, :columns, :diagonals
    super(board, color, pos)
    @directions = directions
  end

  def pos_moves
    directions.each do |direction|
    if (:rows)
  end

end
#
# class Bishop << SlidingPiece
#
# end
#
# class Rook << SlidingPiece
# end
#
# class Queen << SlidingPiece
# end

class Pawn << Piece

end
