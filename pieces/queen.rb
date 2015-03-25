class Queen < Slideable
  def symbol
    color == :white ? '♕' : '♛'
  end

  protected

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end
