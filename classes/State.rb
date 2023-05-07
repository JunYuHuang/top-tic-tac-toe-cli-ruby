class State
  def initialize(board = Board.new, turn = Piece.CROSS)
      @board = board
      @turn = turn
  end

  attr_accessor(:board)
  attr_accessor(:turn)

  def set_turn
      @turn = @turn == Piece.CROSS ? Piece.CIRCLE : Piece.CROSS
  end

  def is_game_over?
      if !@board.meets_min_win_condition?
          return false
      end
      if (@board.did_win?(Piece.CROSS) or
          @board.did_win?(Piece.CIRCLE))
          return true
      end
      @board.is_full?
  end

  def set_board(row, col)
      if !@board.is_placeable?(row, col)
          return false
      end
      @board.place(row, col, @turn)
      true
  end

  def get_winner
      if !is_game_over?
          return nil
      end
      if @board.did_win?(Piece.CROSS)
          return Piece.CROSS
      end
      if @board.did_win?(Piece.CIRCLE)
          return Piece.CIRCLE
      end
      Piece.EMPTY
  end
end
