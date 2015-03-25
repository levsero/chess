class Queen < Piece
  include slideable

  def initialize
    super(board, color, pos)
    @symbol = @color == :white ? "\u{2655}" : "\u{265B}"
  end

  protected

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end
