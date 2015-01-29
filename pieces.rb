require_relative "checkers.rb"

class Piece
  attr_reader :color, :board, :position, :king

  RED_DIRS   = [[-1,1], [-1,-1]]
  BLACK_DIRS = [[ 1,1], [ 1,-1]]

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
    @king = false

    #make it put itself on the board @board.add_piece(self)
  end

  def move(direction)
    if perform_slide(direction)
      "Slide performed!"
    elsif perform_jump(direction)
      "Jump performed!"
    else
      "Not a valid direction"
    end
  end

  def perform_slide(destination)
    move_diffs.include?(destination)
  end

  def perform_jump(destination)

    #return true or false
  end

  def move_directions
    possible_directions = []

    if king
      possible_directions.concat(RED_DIRS).concat(BLACK_DIRS)
    elsif color == :red
      possible_directions.concat(RED_DIRS)
    else
      possible_directions.concat(BLACK_DIRS)
    end

    possible_directions.concat(possible_directions.map { |(y,x)| [y*2, x*2] })
  end

  def move_locations
    curr_y, curr_x = @position

    move_directions.map do |(dy, dx)|
      [curr_y + dy, curr_x + dx]
    end.select { |pos| on_the_board?(pos) }
  end

  def on_the_board?(pos)
    pos.all? { |coord| coord.between?(0,7) }
  end

  def promote
    @king = true
  end

  def maybe_promote
    #should ask if it's in the back row - if so, it should promote;
  end


end
