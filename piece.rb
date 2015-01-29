require_relative "checkers.rb"

class Piece
  attr_reader :color, :board, :position, :king

  RED_DIRS   = [[ 1,1], [ 1,-1]]
  BLACK_DIRS = [[-1,1], [-1,-1]]

  def initialize(color, board, position)
    @color, @board, @position, @king = color, board, position, false

    @board.place_piece(self)
  end

  def perform_moves!(move_sequence)
    if move_sequence.count == 1
      move_to(move_sequence.first) #should this raise an error if it fails?
    else
      move_sequence.each do |destination|
        raise InvalidMoveError.new unless perform_jump(destination)
      end
    end
  end

  def move_to(destination)
    perform_slide(destination) || perform_jump(destination)
  end

  def perform_slide(destination)
    if valid_slide?(destination)
      move_to!(destination)
      true
    else
      false
    end
  end

  def perform_jump(destination)
    if valid_jump?(destination)
      @board.remove_piece_at(jumped_position(destination))
      move_to!(destination)
      true
    else
      false
    end
  end

  def move_to!(destination)
    @board.remove_piece_at(@position)

    @position = destination
    @board.place_piece(self)
  end

  def valid_slide?(destination)
    move_locations(:slide).include?(destination) &&
      @board[destination].nil?
  end

  def valid_jump?(destination)
    move_locations(:jump).include?(destination) &&
      @board[destination].nil? &&
      jumps_enemy?(destination)
  end

  def jumps_enemy?(destination)
    jumped_piece = @board[jumped_position(destination)]

    return false if jumped_piece.nil?
    jumped_piece.color != color
  end

  def jumped_position(destination)
    dest_y, dest_x = destination
    curr_y, curr_x = @position
    [(dest_y + curr_y)/2, (dest_x + curr_x)/2]
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
