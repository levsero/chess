class HumanPlayer
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def get_move
    puts"Choose Piece:(e.g. E2)"
    piece = gets.chomp
    piece = convert_input(piece)

    puts"Choose Move:(e.g. E4)"
    move = gets.chomp
    move = convert_input(move)

    [piece, move]
  end

  def convert_input(input)
    input = input.split("")

    input[0], input[1] = 8 - input[1].to_i, input[0].downcase.ord - 97

    input
  end
end
