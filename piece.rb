class Piece
  attr_accessor :symbol, :color, :pos, :board
  def initialize(board, color, pos, symbol)
    @board = board
    @color = color
    @pos = pos
    @symbol = symbol
  end

  def move(end_pos)
    board[pos] , board[end_pos] = nil, self
    self.pos = end_pos
  end

end
