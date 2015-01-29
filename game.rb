require_relative "checkers.rb"

class CheckersGame

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(:black)
    @player2 = HumanPlayer.new(:red)
  end


  def run
    @current_player = @player1

    until @board.game_over?
      begin
        @board.display
        piece = @board[@current_player.select_piece]
        moves = @current_player.select_move_sequence

        piece.perform_moves(moves)
      rescue ArgumentError => e
        puts "Invalid input:"
        puts e
        retry
      rescue CheckersError => e
        puts "Invalid move(s):"
        puts e
        retry
      end

      toggle_player
    end


  end


  def toggle_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

end
