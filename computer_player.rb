class ComputerPlayer
  attr_accessor :color

  def initialize(color, board)
    @board = board
    @color = color
  end

  def get_move
    get_legal_moves

    test_mate = find_checkmate
    return test_mate unless test_mate.nil?

    select_random_move
  end

  def get_legal_moves
    @legal_moves = Hash.new{|h,k| h[k] = []}
    @board.pieces(:color => @color).each do |piece|
      @legal_moves[piece.pos] = piece.legal_moves
    end
    @legal_moves.select!{|key, val| val.any?}
  end

  def select_random_move
    pos = @legal_moves.keys.sample
    move = @legal_moves[pos].sample
    [pos, move]
  end

  def find_checkmate
    @legal_moves.each do |pos, moves_arr|
      moves_arr.each do |end_move|
        dupe = @board.dup

        dupe[pos].move(end_move)

        opp_color = color == :white ? :black : :white
        return [pos, end_move] if dupe.check_mate?(opp_color)
      end
    end
    nil
  end
end
