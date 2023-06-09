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
