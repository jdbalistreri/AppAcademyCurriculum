require_relative "checkers.rb"

class Board
  attr_reader :rows

  def initialize #this could take an empty argument
    fill_board #make this an array of pieces, need a fill board method
  end

  def fill_board #this could take a true/false value
    @rows = Array.new(8) { Array.new(8) }
  end

  def add_piece(piece)
    self[piece.position] = piece
  end

  def remove_piece_at(position)
    raise CheckersError.new "No piece at that position" if self[position].nil?

    self[position] = nil
  end

  def empty?(destination)
    y, x = destination
    @rows[y][x].nil?
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
