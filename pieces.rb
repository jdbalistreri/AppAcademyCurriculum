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

  def inspect
    "#{@color} #{@king ? "king" : "piece"} at #{@position}"
  end

  def move(destination)
    if perform_slide(destination)
      "Slide performed!"
    elsif perform_jump(destination)
      "Jump performed!"
    else
      "Not a valid direction"
    end
  end

  def perform_slide(destination)
    if move_locations(slide_deltas).include?(destination)
      @board.empty?(destination)
    end
    false
  end

  def perform_jump(destination)
    if move_locations(jump_deltas).include?(destination)
      @board.empty?(destination) && jumps_enemy?(destination)
    end
    false
  end

  def jumps_enemy?(destination)
    dest_y, dest_x = destination
    curr_y, curr_x = @position
    jumped_piece = @board[[(dest_y + curr_y)/2, (dest_x + curr_x)/2]]

    raise "You must jump over something." if jumped_piece.nil?
    jumped_piece.color != color
  end

  def promote
    @king = true
  end

  def maybe_promote
    #should ask if it's in the back row - if so, it should promote;
  end

  private
    def move_directions
      return RED_DIRS.concat(BLACK_DIRS) if king

      color == :red ? RED_DIRS : BLACK_DIRS
    end

    def slide_deltas
      move_directions
    end

    def jump_deltas
      move_directions.map { |(y,x)| [y*2, x*2] }
    end

    def move_locations(deltas)
      curr_y, curr_x = @position

      deltas.map do |(dy, dx)|
        [curr_y + dy, curr_x + dx]
      end.select { |pos| on_the_board?(pos) }
    end

    def on_the_board?(pos)
      pos.all? { |coord| coord.between?(0,7) }
    end

end
