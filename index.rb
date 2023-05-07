class Piece
    @@CROSS = :cross
    @@CIRCLE = :circle
    @@EMPTY = :empty

    def self.CROSS
        @@CROSS
    end

    def self.CIRCLE
        @@CIRCLE
    end

    def self.EMPTY
        @@EMPTY
    end
end

class Board
    @@default_size = 3

    def initialize(grid = nil, size = @@default_size)
        @grid = grid ? grid : Board.get_default_grid(size)
        @size = grid ? grid.length : @@default_size
        @pieces_placed = 0
        if !grid
            return
        end
        size.times do |r|
            size.times do |c|
                if grid[r][c] != Piece.EMPTY
                    @pieces_placed += 1
                end
            end
        end
    end

    def self.get_default_grid(size)
        board = Array.new(size) { Array.new(size) }
        size.times do |r|
            size.times do |c|
                board[r][c] = Piece.EMPTY
            end
        end
        board
    end

    attr_reader(:size)
    attr_accessor(:grid)
    attr_accessor(:pieces_placed)

    def is_placeable?(row, col)
        def is_invalid?(input)
            is_not_int = input.class != Integer
            is_not_in_range = input.to_i < 0 || input.to_i >= @size
            is_not_int or is_not_in_range
        end
        if is_invalid?(row) or is_invalid?(col)
            return false
        end
        @grid[row][col] == Piece.EMPTY
    end

    def place(row, col, piece)
        @grid[row][col] = piece
        @pieces_placed += 1
    end

    def meets_min_win_condition?
        @pieces_placed >= @size * 2 - 1
    end

    def is_full?
        @pieces_placed == @size * @size
    end

    def did_win_rows?(piece)
        @size.times do |r|
            count = 0
            @grid[r].each do |cell|
                if cell == piece
                    count += 1
                end
            end
            if count == @size
                return true
            end
        end
        false
    end

    def did_win_cols?(piece)
        @size.times do |c|
            count = 0
            @size.times do |r|
                if @grid[r][c] == piece
                    count += 1
                end
            end
            if count == @size
                return true
            end
        end
        false
    end

    def did_win_pos_diag?(piece)
        r = @size - 1
        c = 0
        count = 0
        while r >= 0 && c < @size
            if @grid[r][c] == piece
                count += 1
            end
            r -= 1
            c += 1
        end
        count == @size
    end

    def did_win_neg_diag?(piece)
        r = 0
        c = 0
        count = 0
        while r < @size && c < @size
            if @grid[r][c] == piece
                count += 1
            end
            r += 1
            c += 1
        end
        count == @size
    end

    def did_win?(piece)
        if (did_win_rows?(piece) or
            did_win_cols?(piece) or
            did_win_pos_diag?(piece) or
            did_win_neg_diag?(piece))
            return true
        end
        false
    end
end

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
        "Place your piece #{@@piece_to_string[piece]} on the board.\n
        For example, 1,1 represents the top-left cell on the board.\n
        Enter its position in the format 'row,col' without the quotes:\n"
    end
end
