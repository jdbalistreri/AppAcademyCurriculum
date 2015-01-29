require_relative "checkers.rb"

class Board

  def initialize #this could take an empty argument
    fill_board #make this an array of pieces, need a fill board method
  end

  def fill_board #this could take a true/false value
    @rows = Array.new(8) { Array.new(8) }
  end

  def add_piece(piece)
    #this takes a piece object and then will place it using the pieces coordinates
  end

  def remove_piece(position)
    #this should remove a piece, for instance, after a jump
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
