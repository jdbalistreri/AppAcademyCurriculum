require_relative "checkers.rb"

class HumanPlayer

  attr_reader :color

  def initialize(color, board)
    @color = color
    @board = board
  end

  def select_piece
    print "Which piece (e.g. '1,2') would you like to move?  "
    position = parse_pos(gets.chomp)

    valid_location?(position)
    position
  end

  def select_move_sequence
    puts "Where would you live to move your piece?"
    puts "If you are going to input multiple coords, please put a space"
    print "between each set of coordinates (e.g. '3,2 1,0'):  "

    moves = gets.chomp.split(" ").map { |pos| parse_pos(pos) }
    raise InvalidMoveError.new "You have to make a move each turn." if moves.empty?

    moves.each { |move| valid_location?(move) }

    moves
  end

  def valid_location?(position)
    if position.count != 2
      raise InvalidMoveError.new "Your input must be two numbers, separated by a comma"
    elsif position.any? { |el| !el.between?(0,7) }
      raise InvalidMoveError.new "Both numbers must be between 0 and 7 (inclusive)"
    elsif (position[0] + position[1]).even?
      raise InvalidMoveError.new "That position is not used by the game"
    end
  end

  def parse_pos(position)
    position.split(",").map { |el| Integer(el) }
  end

end

class ComputerPlayer

  attr_reader :color

  def initialize(color, board)
    @color = color
    @board = board
  end

  def select_piece
    @my_pieces = @board.pieces.select { |piece| piece.color == color }
    @current_piece = @my_pieces.select { |piece| !piece.valid_moves.empty? }.sample
    sleep(0.25)
    @current_piece.position
  end

  def select_move_sequence
    [@current_piece.valid_moves.sample]
  end
end
