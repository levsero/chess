# encoding: utf-8
class Stepable < Piece
  def initialize(board, color, pos)
    super(board, color, pos)
  end

  def moves
    self.class::DELTAS.map do |delta|
      [delta[0] + pos[0], delta[1] + pos[1]]
    end.select do |pos|
      pos[0].between?(0,7) && pos[1].between?(0,7)
    end.select do |pos|
      board[pos].nil? || board[pos].color != color
    end
  end

  def render
    symbol
  end
end
