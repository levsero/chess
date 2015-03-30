class Bishop < Slideable

  def value
    3
  end

  def symbol
    color == :white ? '♗' : '♝'
  end

  protected

  def move_dirs
    diagonal_dirs
  end
end
