require_relative "checkers.rb"

class HumanPlayer

  def initialize(color)
    @color = color
  end

  def select_piece
    puts "#{@color.to_s.capitalize}'s turn."
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
    moves.each { |move| valid_location?(move) }

    moves
  end

  def valid_location?(position)
    if position.count != 2
      raise ArgumentError.new "Your input must be two numbers, separated by a comma"
    elsif position.any? { |el| !el.between?(0,7) }
      raise ArgumentError.new "Both numbers must be between 0 and 7 (inclusive)"
    elsif (position[0] + position[1]).even?
      raise ArgumentError.new "That position is not used by the game"
    end
  end

  def parse_pos(position)
    position.split(",").map { |el| Integer(el) }
  end

end


class ComputerPlayer

  def initialize(color)
    @color = color
  end


end
