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

class SlidingPiece < Piece
  # Bishop, Queen, Rook

  def initialize(*directions) # :rows, :cols, :diags
    super(board, color, pos)
    @directions = directions
  end

  def pos_moves
    get_direction
    directions.each do |direction|
    end

  end

  def get_direction
    # @directions.each{|direction| direction_hash[direction] = []}
  end

  def create_deltas
    @direction_hash = {} #Hash.new{|h,k| h[k] = []}
    @direction_hash[:rows] = get_row
    @direction_hash[:cols] = get_col
    @direction_hash[:diag1], @direction_hash[:diag2] = get_diags
  end

  def get_row
    row = []
    board.rows[pos[0]].each_index{|col| row << [pos[0], col]}
    row
  end

  def get_col
    col = []
    board.rows.each_index{|row| col << [row, pos[1]]}
    col
  end

  def get_diags
    diag1 = []
    diag2 = []
    8.times do |num|
      diag1 << [num, num]
      diag1 << [-num, -num]
      diag2 << [-num, num]
      diag2 << [num, -num]
    end
    [diag1.sort, diag2.sort]

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

class Pawn < Piece

end
