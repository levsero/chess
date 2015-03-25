# encoding: utf-8
require_relative 'pieces'
require 'colorize'

class Board
  attr_accessor :rows

  def initialize(set = false)
    @rows = Array.new(8){Array.new(8)}
    set_board if set == true
  end

  def game_over?(color)
    pieces(:color => color).each do |piece|
      if !piece.legal_moves.empty?
        #p piece.symbol
        return false
      end
    end
    true
  end

  def check_mate?(color)
    game_over?(color) && in_check?(color)
  end


  def in_check?(color)
    king = find_king(color)

    # check every piece of opposite color's legal moves
    pieces(:color => color, :opp => true).each do |piece|
      return true if piece.pos_moves.include?(king)
    end

    false
  end

  def find_king(color)
    pieces(:color => color).each {|piece| return piece.pos if piece.is_a?(King) }
  end

  def pieces(options = {})
    default = {:color => :all, :opp => false}
    options = default.merge(options)

    options[:color] = options[:color] == :black ? :white : :black if options[:opp]

    @rows.flatten.select { †|tile| !tile.nil? &&
        (tile.color == options[:color] || options[:color] == :all) }
  end

  def move(start_pos, end_pos, turn_color)
    raise ArgumentError.new("No piece at start position") if self[start_pos].nil?
    raise ArgumentError.new("Illegal move") if !self[start_pos].legal_moves.include?(end_pos)
    raise ArgumentError.new("Not your piece") if self[start_pos].color != turn_color

    self[start_pos].move(end_pos)
  end

  def dup
    dupe = Board.new
    pieces.each { |piece| dupe[piece.pos] = piece.dup(dupe) }
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
    [[0,0], [0,7], [7,0], [7,7]].each do |pos|
      color = pos[0] == 0 ? :black  : :white
      self[pos] = Slideable.new(self, color, [7,7], "\u{2656}", :rows, :cols)
    end
  end

  def create_knights
    [[0,1], [0,6], [7,1], [7,6]].each do |pos|
      color = pos[0] == 0 ? :black  : :white
      board[pos] = Knight.new(self, color, [0,1], "\u{265E}")
    end
  end

  def create_bishops
    [[0,2], [0,5], [7,2], [7,5]].each do |pos|
    color = pos[0] == 0 ? :black  : :white
    self[pos] = Slideable.new(self, color, [7,5], "\u{2657}", :diags)
  end

  def create_queens
    self[[0,3]] = Slideable.new(self, :black, [0,3], "\u{265B}", :rows, :cols, :diags)
    self[[7,3]] = Slideable.new(self, :white, [7,3], "\u{2655}", :rows, :cols, :diags)
  end

  def create_kings
    self[[0,4]] = King.new(self, :black, [0,4], "\u{265A}")
    self[[7,4]] = King.new(self, :white, [7,4], "\u{2654}")
  end

  def create_pawns
    @rows[1].each_index {|col| self[[1, col]] = Pawn.new(self, :black, [1,col], "\u{265F}")}
    @rows[6].each_index {|col| self[[6, col]] = Pawn.new(self, :white, [6,col], "\u{2659}")}
  end

  def display_board
    @rows.map do |row|
        shade = shade == :light_blue ? :light_green : :light_blue
        row.map do |piece|
          square = piece.nil? ? '   ' : " #{piece.render} "
          square.colorize(:background => shade)
        end.join
      end.join("\n")
    end
  end

end
