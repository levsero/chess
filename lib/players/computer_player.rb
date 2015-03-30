class ComputerPlayer
  # TODO AI upgrades
  # increase value of bishops slightly if still have 2 bishops
  # queens early game reduce mobility points
  # overly focuses on checking b/c cheking reduces the opp mobility

  attr_accessor :color

  def initialize(color, board, recurse = 1)
    @board = board
    @color = color
    @recurse = recurse
  end

  def get_move
    moves = get_legal_moves
    select_best_move(moves)[0]
  end

  def select_best_move(moves, recurse = @recurse, color = @color, board = @board)
    best_value = -50
    best_move = nil
    best_moves = []

    # iterate through each move to find best one
    moves.each do |from, move_set|
      move_set.each do |move|

        # gets piece arrays for both colors from before move being tested
        before_opp = board.pieces(color: color, opp: true)
        before_cur = board.pieces(color: color)

        # dup board and move
        dup = board.dup
        dup.move(from, move, color)

        # return move if causes check_mate(1000 to cause other player to avoid it)
        opp_color = color == :white ? :black : :white
        return [[from, move], 1000] if dup.check_mate?(opp_color)

        # gets piece array for both colors from after move being tested
        after_opp = dup.pieces(color: color, opp: true)
        after_cur = dup.pieces(color: color)

        # get piece type
        piece = board[from].class

        # calc position rating
        rating = calc_postion_rating(before_opp, before_cur, after_opp, after_cur, piece)

        rating += 2 if piece == Pawn

        #calc opp player best response
        if recurse > 0
            opp_color = (@color == :black) ? :white : :black
            moves = get_legal_moves(opp_color, dup)
            # p moves.keys
            opp = select_best_move(moves, recurse - 1, opp_color, dup)[1]

            # prevent stalemate when have other options
            opp = 100 if moves.length == 0

            rating -= opp
        end

        # updates best move if better than current best move
        if rating > best_value || best_move.nil?
          best_value, best_move = rating, [from, move]
          best_moves << best_move
        elsif rating == best_value
          #randomizes best move if equal
          #TODO if multiple equal 50% last one
          best_move = [[from, move], best_move].sample
        end
      end
    end

    [best_move, best_value]
  end

  def calc_postion_rating(before_opp, before_cur, after_opp, after_cur, piece_class)
    points = calc_points(before_opp, after_opp)
    mobility = calc_mobility(after_cur)

    points * 5 + mobility
  end

  def calc_points(before_opp, after_opp)
    before_opp.map{|piece| piece.value}.inject(:+) - after_opp.map{|piece| piece.value}.inject(:+)
  end

  def calc_mobility(after_cur)
    mob = 0
    after_cur.each do |piece|
      piece.moves.each do |move|
        if move.all?{|pos| pos.between?(2, 5)}
          mob += 1.5
        elsif move.any?{|pos| pos == 0 || pos == 7}
          mob += 0.5
        else
          mob += 1
        end
      end
    end
    mob
  end

  def get_legal_moves(color = @color, board = @board)
    legal_moves = Hash.new{|h,k| h[k] = []}
    # p "opp:#{color}, col:#{@color}"

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
end
