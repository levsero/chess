class Rook < Slideable
  def symbol
    color == :white ? '♖' : '♜'
  end

  protected

  def move_dirs
    horizontal_dirs
  end
end
