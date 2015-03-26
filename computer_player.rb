class ComputerPlayer
  attr_accessor :color

  def initialize(color, board)
    @board = board
    @color = color
  end

  def get_move
    moves = get_legal_moves

    test_mate = find_checkmate(moves)

    return test_mate if test_mate
    select_random_move(moves)

    # select_best_move(moves)
  end

  def select_best_move

  end

  def get_legal_moves
    legal_moves = Hash.new{|h,k| h[k] = []}
    @board.pieces(:color => color).each do |piece|
      legal_moves[piece.pos] = piece.legal_moves
    end
    # remove any pieces that don't have any legal moves
    legal_moves.select!{|key, val| val.any?}
  end

  def select_random_move(moves)
    pos = moves.keys.sample
    move = moves[pos].sample
    [pos, move]
  end

  def find_checkmate(moves)
    moves.each do |pos, moves_arr|
      moves_arr.each do |end_move|

        # dup board instead of trying to reverse
        dupe = @board.dup
        dupe[pos].move(end_move)
        opp_color = color == :white ? :black : :white

        return [pos, end_move] if dupe.check_mate?(opp_color)
      end
    end
    nil
  end
end
