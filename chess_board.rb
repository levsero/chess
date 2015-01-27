require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'pawn'

class Board
  attr_accessor :rows

  def initialize
    @rows = Array.new(8){Array.new(8)}
    set_board
  end

  def set_board
    create_rooks
    create_knights
    create_bishops
    create_queens
    create_kings
    create_pawns
  end

  def create_rooks
    self[0,0] = SlidingPiece.new(self, :black, [0,0], :rows, :cols)
    self[0,7] = SlidingPiece.new(self, :black, [0,7], :rows, :cols)
    self[7,0] = SlidingPiece.new(self, :white, [7,0], :rows, :cols)
    self[7,7] = SlidingPiece.new(self, :white, [7,7], :rows, :cols)
  end

  def create_knights
    self[0,1] = Knight.new(self, :black, [0,1])
    self[0,6] = Knight.new(self, :black, [0,6])
    self[7,1] = Knight.new(self, :white, [7,1])
    self[7,6] = Knight.new(self, :white, [7,6])
  end

  def create_bishops
    self[0,2] = SlidingPiece.new(self, :black, [0,2], :diags)
    self[0,5] = SlidingPiece.new(self, :black, [0,5], :diags)
    self[7,2] = SlidingPiece.new(self, :white, [7,2], :diags)
    self[7,5] = SlidingPiece.new(self, :white, [7,5], :diags)
  end

  def create_queens
    self[0,3] = SlidingPiece.new(self, :black, [0,3], :rows, :cols, :diags)
    self[7,3] = SlidingPiece.new(self, :white, [7,3], :rows, :cols, :diags)
  end

  def create_kings
    self[0,4] = King.new(self, :black, [0,4])
    self[7,4] = King.new(self, :white, [7,4])
  end

  def create_pawns
    @row[1].each_with_index {|tile, col| tile = Pawn.new(self, :black, [1,col])}
    @row[6].each_with_index {|tile, col| tile = Pawn.new(self, :white, [6,col])}
  end

end
