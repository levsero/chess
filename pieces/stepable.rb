# encoding: utf-8
class Stepable < Piece
  def initialize(board, color, pos, symbol)
    super(board, color, pos, symbol)
  end

  def pos_moves
    self.class::DELTAS.map do |delta|
      [delta[0] + pos[0], delta[1] + pos[1]]
    end.select do |pos|
      pos[0].between?(0,7) && pos[1].between?(0,7)
    end.select do |pos|
      board[pos].nil? || board[pos].color != color
    end
  end

  def legal_moves
    pos_moves.select {|pos_pos| !move_into_check?(pos_pos) }
  end
end
