require_relative "checkers.rb"

class CheckersGame

  def initialize(p1human = false, p2human = false)
    @board = Board.new
    @player1 = p1human ? HumanPlayer.new(:black, @board) : ComputerPlayer.new(:black, @board)
    @player2 = p2human ? HumanPlayer.new(:red, @board)   : ComputerPlayer.new(:red, @board)
  end

  def run
    @current_player = @player1

    load_screen
    gets

    until @board.game_over?(@current_player.color)
      begin
        @board.display
        puts "#{@current_player.color.to_s.capitalize}'s turn."
        piece = @board[@current_player.select_piece]
        raise InvalidMoveError.new "You chose an empty square" if piece.nil?
        raise InvalidMoveError.new "That's not your piece" if piece.color != @current_player.color

        moves = @current_player.select_move_sequence

        piece.perform_moves(moves)
      rescue InvalidMoveError => e
        puts "Invalid move:"
        puts e
        sleep(2)
        retry
      end
      toggle_player
    end

    toggle_player
    @board.display
    puts "Game Over! #{@current_player.color.to_s.capitalize} wins!!"
  end

  def load_screen
    puts "\e[H\e[2J"
    puts "Welcome to Checkers".center(65)
    puts "In order to input a move, you will type the coordinates of the piece"
    puts "you want to move and then the space you want to move to. If you are"
    puts "make multiple moves, you can enter them in a sequence during the"
    puts "move sequence input prompt."
    puts ""
    puts "In order to select a coordinate, enter a pair of numbers separated"
    puts "by a comma, (e.g. '1,2'). In this game, the y-axis coordinate comes"
    puts "first in the pair. For instance, typing '7,0' would select the piece"
    puts "in the bottom left corner."
    puts ""
    puts "If you make an invalid move or select the wrong piece, just press"
    puts "[enter] and you will be able to select a new piece."
    puts ""
    puts "The game ends when one player has lost all their pieces or cannot make"
    puts "any legal moves."
    puts ""
    puts "Press [enter] to begin!"
  end

  def toggle_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end


if __FILE__ == $PROGRAM_NAME

  puts "Welcome to Checkers."
  print "How many human players in this game (0/1/2)?:    "
  case gets.chomp.to_i
  when 1 then CheckersGame.new(true, false).run
  when 2 then CheckersGame.new(true, true).run
  else CheckersGame.new(false, false).run
  end

end
