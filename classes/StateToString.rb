class StateToString
  @@piece_to_string = {
      Piece.CROSS => "X",
      Piece.CIRCLE => "O",
      Piece.EMPTY => " "
  }

  attr_reader(:piece_to_string)

  def self.get_board(board)
      size = board.length
      res = []
      col_header_row = [" " * size.to_s.length]
      size.times do |c|
          col_header_row.push(" #{c + 1}")
      end
      col_header_row.push("\n")
      res.push(col_header_row.join)

      size.times do |r|
          row = [r + 1]
          size.times do |c|
              piece = @@piece_to_string[board[r][c]]
              row.push(" #{piece}")
          end
          row.push("\n")
          res.push(row.join)
      end
      res.join()
  end

  def self.get_turn(turn)
      "It is player #{@@piece_to_string[turn]}'s turn."
  end

  def self.get_game_end(winner)
      if !winner
          return ""
      end
      winner == Piece.EMPTY ?
          "Game Ended: Tie!" :
          "Game Ended: Player #{@@piece_to_string[winner]} won!"
  end

  def self.get_player_prompt(piece)
      [
          "Place your piece #{@@piece_to_string[piece]} on the board.\n",
          "For example, 1,1 represents the top-left cell on the board.\n",
          "Enter its position in the format 'row,col' without the quotes:\n"
      ].join
  end
end
