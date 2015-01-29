require_relative "checkers.rb"
require "colorize"
require "terminfo"

class Board
  attr_reader :rows

  def initialize(fill = true)
    make_board(fill)
  end

  def game_over?
    false
    #check
  end

  def display
    display_header
    puts render
  end

  def display_header
    puts "\e[H\e[2J"
    puts "---*~*~*~*~ CHECKERS ~*~*~*~*---"
    2.times { puts "" }
  end

  def render
    tile_count = 0
    row_num = -1
    output = @rows.map do |row|
      row_num += 1
      tile_count += 1
      row_array = ["   ", row_num]
      row_array += row.map do |x|
        tile_count += 1
        string = x.nil? ? "   " : x.render
        string = tile_count.odd? ? string.colorize(background: :green) : string.colorize(background: :white)
        string
      end
      row_array.join("")
    end
    output += ["     #{(0..7).to_a.join("  ")}"]
    output
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

  def place_piece(piece)
    self[piece.position] = piece
  end

  def remove_piece_at(position)
    raise InvalidMoveError.new "No piece at that position" if self[position].nil?

    self[position] = nil
  end

  def dup
    clone = Board.new(false)

    pieces.each do |piece|
      Piece.new(piece.color, clone, piece.position.dup, piece.king)
    end

    clone
  end

  def pieces
    @rows.flatten.compact
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
