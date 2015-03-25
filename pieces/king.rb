class King < Stepable
  DELTAS = [[-1, -1], [-1, 0], [-1, 1],
             [0, -1],           [0, 1],
             [1, -1], [1, 0],   [1, 1]]

  def symbol
     color == :white ? '♔' : '♚'
  end
end
