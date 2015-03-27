class Slideable < Piece
  # Bishop, Queen, Rook
  HORIZONTAL_DIRS = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]
  ]

  DIAGONAL_DIRS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ]

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    moves = []

    # loops through each direction getting all its pos moves
    move_dirs.each do |dx, dy|
      moves.concat(all_moves_in_dir(dx, dy))
    end

    moves
  end

  def render
    symbol
  end

  private

  def move_dirs
    # subclass implements this
    raise NotImplementedError
  end

  def all_moves_in_dir(dx, dy)
    cur_x, cur_y = pos
    moves = []
    loop do
      cur_x, cur_y = cur_x + dx, cur_y + dy
      pos = [cur_x, cur_y]

      break unless board.valid_pos?(pos)

      if board[pos].nil?
        moves << pos
      else
        # can take an opponent's piece
        moves << pos if board[pos].color != color

        # can't move past blocking piece
        break
      end
    end
    moves
  end

end
