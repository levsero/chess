class ComputerPlayer2
  attr_accessor :color

  def initialize(color, board)
    @board = board
    @color = color
  end

  def get_move
    moves = get_legal_moves

    mate = find_checkmate(moves)

    return mate if mate

    select_best_move(moves)[0]
  end

  def calc_postion_rating(before_opp, before_cur, after_opp, after_cur)
    points = calc_points(before_opp, after_opp)

    mobility = calc_mobility(after_cur)

    points * 5 + mobility
  end

  def calc_points(before_opp, after_opp)
    before_opp.map{|piece| piece.value}.inject(:+) - after_opp.map{|piece| piece.value}.inject(:+)
  end

  def calc_mobility(after_cur)
    mob = 0
    mobility = after_cur.each do |piece|
      piece.moves.each do |move|
        mob += 1
      end
    end
    mob
  end

  def get_legal_moves(color = @color, board = @board)
    legal_moves = Hash.new{|h,k| h[k] = []}
    board.pieces(:color => color).each do |piece|
      legal_moves[piece.pos] = piece.legal_moves
    end
    # remove any pieces that don't have any legal moves
    legal_moves.select{|key, val| val.any?}
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

  def select_best_move(moves, recurse = true)
    best_value = 0
    best_move = nil

    # iterate through each move to find best one
    moves.each do |from, move_set|
      move_set.each do |move|

        # gets piece array from before move being tested
        before_opp = @board.pieces(color: @color, opp: true)
        before_cur = @board.pieces(color: @color)

        # dup board and move
        dup = @board.dup
        dup.move(from, move, @color)

        # gets piece array from after move being tested
        after_opp = dup.pieces(color: @color, opp: true)
        after_cur = dup.pieces(color: @color, opp: true)

        # calc position rating
        rating = calc_postion_rating(before_opp, before_cur, after_opp, after_cur)
        # if @board[from].class == Pawn
        #   rating += 2
        # end

        # updates best move if better than current best move
        if rating > best_value || best_move.nil?
          best_value, best_move = rating, [from, move]
        elsif rating == best_value
          #randomizes best choice if equal
          best_move = [[from, move], best_move].sample
        end
      end
    end
    [best_move, best_value]
  end

end
