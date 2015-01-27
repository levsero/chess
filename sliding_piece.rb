class SlidingPiece < Piece
  # Bishop, Queen, Rook

  def initialize(board, color, pos, symbol, *directions) # :rows, :cols, :diags
    super(board, color, pos, symbol)
    @directions = directions
  end

  def legal_moves
    legal_moves_arr = []
    pos_moves.each do |direction_array|
      direction_array.each do |one_direction_arr|
        one_direction_arr.each do |tile|
          if board[tile].nil?
            legal_moves_arr << tile
          elsif board[tile].color != color
            legal_moves_arr << tile
            break
          else
            break
          end
        end
      end
    end

    legal_moves_arr
  end

  def pos_moves
    possible_moves = []
    direction_hash = create_deltas

    @directions.each do |direction|
      possible_moves << direction_hash[direction]
    end

    possible_moves
  end

  def create_deltas
    direction_hash = {} #Hash.new{|h,k| h[k] = []}

    direction_hash[:rows] = get_row
    direction_hash[:cols] = get_col
    direction_hash[:diags] = get_diags

    direction_hash
  end

  def get_row
    row = Array.new(2) {[]}
    board.rows[pos[0]].each_index do |col|
      col < pos[1] ? row[0] << [pos[0], col] : row[1] << [pos[0], col]
    end

    # puts row[0] in order of closness
    row[0].reverse!

    row
  end

  def get_col
    col = Array.new(2) {[]}
    board.rows.each_index do |row|
      row < pos[0] ? col[0] << [row, pos[1]] : col[1] << [row, pos[1]]
    end

    # puts col[0] in order of closeness
    col[0].reverse!

    col
  end

  def get_diags
    diag = Array.new(4) {[]}

    (1..7).each do |num|
      diag[0] << [pos[0] + num, pos[1] + num]
      diag[1] << [pos[0] - num, pos[1] - num]
      diag[2] << [pos[0] - num, pos[1] + num]
      diag[3] << [pos[0] + num, pos[1] - num]
    end

    # filter out of bounds
    diag[0].select!{|el| el[0].between?(0,7) && el[1].between?(0,7)}
    diag[1].select!{|el| el[0].between?(0,7) && el[1].between?(0,7)}
    diag[2].select!{|el| el[0].between?(0,7) && el[1].between?(0,7)}
    diag[3].select!{|el| el[0].between?(0,7) && el[1].between?(0,7)}

    diag
  end

end
