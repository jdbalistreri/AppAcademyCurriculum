require_relative "checkers.rb"

class Board
  attr_reader :rows

  def initialize(fill = true)
    make_board(fill)
  end

  def make_board(fill)
    @rows = Array.new(8) { Array.new(8) }
    [:red, :black].each { |color| fill_board_with(color) } if fill
  end

  def fill_board_with(color)
    row_range = color == :red ? (0..2) : (5..7)

    row_range.each do |row|
      (0..7).each do |col|
        Piece.new(color, self, [row, col]) if (row + col).odd?
      end
    end
  end

  def add_piece(piece)
    self[piece.position] = piece
  end

  def remove_piece_at(position)
    raise CheckersError.new "No piece at that position" if self[position].nil?

    self[position] = nil
  end

  def [](pos)
    y,x = pos
    @rows[y][x]
  end

  def []=(pos, value)
    y,x = pos
    @rows[y][x] = value
  end
end
