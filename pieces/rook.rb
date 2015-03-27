class Rook < Slideable
  def symbol
    color == :white ? '♖' : '♜'
  end

  def value
    5
  end

  protected

  def move_dirs
    horizontal_dirs
  end
end
