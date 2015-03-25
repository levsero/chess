class Knight < Stepable
  DELTAS = [[-1, -2], [-2, -1], [-2, 1],
             [1, -2],           [2, -1],
             [-1, 2], [1, 2],   [2, 1]]

  def symbol
   color == :white ? '♘' : '♞'
  end
end
