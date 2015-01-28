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

  def in_check?(color)
    king = find_king(color)

    # check every piece of opposite color's legal moves
    pieces(color, true).each do
      |piece| return true if piece.pos_moves.include?(king)
    end

    false
  end

  def find_king(color)
    pieces(color).each {|piece| return piece.pos if piece.is_a?(King) }
  end

  def pieces(color, opp = false)
    color = color == :black ? :white : :black if opp

    #flatten rows and select pieces (of color or opposite)
    @rows.flatten.select {|tile| !tile.nil? && tile.color == color }
  end

  def move(start_pos, end_pos)
    puts "board move method"
    raise "No piece at start position" if self[start_pos].nil?
    raise "Illegal move" if !self[start_pos].legal_moves.include?(end_pos)
    self[start_pos].move(end_pos)
    # update all legal_move_array

  end

  def dup
    dupe = Board.new

    # @rows.flatten.each do |tile|
    #   if tile.nil?
    #     dupe[tile.pos] = nil
    #   else
    #     dupe[tile.pos] = self[tile.pos].dup(dupe)
    #   end
    # end
    @rows.each_with_index do |array, row|
      array.each_index do |col|
        if self[[row,col]].nil?
          dupe[[row,col]] = nil
        else
          dupe[[row,col]] = self[[row,col]].dup(dupe)
        end
      end
    end

    dupe
  end

  def set_board
    create_rooks
    create_knights
    create_bishops
    create_queens
    create_kings
    create_pawns
  end

  def [](pos)
    x,y = pos[0], pos[1]
    @rows[x][y]
  end

  def []=(pos, value)
    x, y = pos[0], pos[1]
    @rows[x][y] = value
  end

  def create_rooks
    self[[0,0]] = SlidingPiece.new(self, :black, [0,0], :R, :rows, :cols)
    self[[0,7]] = SlidingPiece.new(self, :black, [0,7], :R, :rows, :cols)
    self[[7,0]] = SlidingPiece.new(self, :white, [7,0], :r, :rows, :cols)
    self[[7,7]] = SlidingPiece.new(self, :white, [7,7], :r, :rows, :cols)
  end

  def create_knights
    self[[0,1]] = Knight.new(self, :black, [0,1], :N)
    self[[0,6]] = Knight.new(self, :black, [0,6], :N)
    self[[7,1]] = Knight.new(self, :white, [7,1], :n)
    self[[7,6]] = Knight.new(self, :white, [7,6], :n)
  end

  def create_bishops
    self[[0,2]] = SlidingPiece.new(self, :black, [0,2], :B, :diags)
    self[[0,5]] = SlidingPiece.new(self, :black, [0,5], :B, :diags)
    self[[7,2]] = SlidingPiece.new(self, :white, [7,2], :b, :diags)
    self[[7,5]] = SlidingPiece.new(self, :white, [7,5], :b, :diags)
  end

  def create_queens
    self[[0,3]] = SlidingPiece.new(self, :black, [0,3], :Q, :rows, :cols, :diags)
    self[[7,3]] = SlidingPiece.new(self, :white, [7,3], :q, :rows, :cols, :diags)
  end

  def create_kings
    self[[0,4]] = King.new(self, :black, [0,4], :K)
    self[[7,4]] = King.new(self, :white, [7,4], :k)
  end

  def create_pawns
    @rows[1].each_index {|col| self[[1, col]] = Pawn.new(self, :black, [1,col], :P)}
    @rows[6].each_index {|col| self[[6, col]] = Pawn.new(self, :white, [6,col], :p)}
  end

  def display_board
    @rows.each_with_index do |array, row|
      array.each_index do |col|
        print self[[row,col]].nil? ? "_ " : "#{self[[row,col]].symbol} "
      end
    puts
    end
    nil
  end
end
