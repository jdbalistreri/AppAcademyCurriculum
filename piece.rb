require_relative "checkers.rb"

class Piece
  attr_reader :color, :board, :position, :king

  RED_DIRS   = [[ 1,1], [ 1,-1]]
  BLACK_DIRS = [[-1,1], [-1,-1]]

  def initialize(color, board, position)
    @color, @board, @position, @king = color, board, position, false

    @board.add_piece(self)
  end

  def move(destination)
    perform_slide(destination) || perform_jump(destination)
  end

  def perform_slide(destination)
    move_locations(:slide).include?(destination) &&
      @board[destination].nil?
  end

  def perform_jump(destination)
    move_locations(:jump).include?(destination) &&
      @board[destination].nil? &&
      jumps_enemy?(destination)
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

  def inspect
    value = @color == :red ? "red" : "blk"
    @king ? value.upcase : value
  end

  # private
    def move_directions
      return RED_DIRS.concat(BLACK_DIRS) if king

      color == :red ? RED_DIRS : BLACK_DIRS
    end

    def move_locations(move_type)
      deltas = move_directions.dup
      deltas.map! { |(y,x)| [y*2, x*2] } if move_type == :jump

      curr_y, curr_x = @position

      deltas.map do |(dy, dx)|
        [curr_y + dy, curr_x + dx]
      end.select { |pos| on_the_board?(pos) }
    end

    def on_the_board?(pos)
      pos.all? { |coord| coord.between?(0,7) }
    end

end
