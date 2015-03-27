# encoding: utf-8
class Piece
  attr_accessor :color, :pos, :board
  def initialize(board, color, pos)
    @board, @color, @pos = board, color, pos;
  end

  def move(end_pos)
    board[pos] , board[end_pos] = nil, self
    self.pos = end_pos
  end

  # def legal_moves
  ## currently only check for check but can do en-pessant and castling
  #   pos_moves.select {|pos| !move_into_check?(pos) }
  # end

  def move_into_check?(end_pos)
    dupe = board.dup
    dupe[@pos].move(end_pos)
    dupe.in_check?(@color)
  end

  def legal_moves
    moves.select{ |pos| !move_into_check?(pos)}
  end

  def dup(new_board)
    dup_piece = self.class.new(new_board, @color, pos)
  end
end
