class Piece
  attr_reader :symbol, :color, :pos, :board
  def initialize(board, color, pos, symbol)
    @board = board
    @color = color
    @pos = pos
    @symbol = symbol
  end

end
