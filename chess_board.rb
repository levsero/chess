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

  end
end
