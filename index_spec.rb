require_relative 'spec_helper'
require_relative 'index'

RSpec.describe 'Board' do
    describe 'initialise()' do
        it 'returns a blank grid when called with no parameters' do
            board = Board.new
            result = [
                board.pieces_placed,
                board.size,
                board.grid
            ]
            expected_grid = [
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            expected = [0, 3, expected_grid]
            expect(result).to eq(expected)
        end

        it 'returns a non-empty grid when called with a non-empty 2D array' do
            random_grid = [
                [Piece.EMPTY, Piece.CIRCLE, Piece.CROSS],
                [Piece.CROSS, Piece.CROSS, Piece.CROSS],
                [Piece.CIRCLE, Piece.EMPTY, Piece.CIRCLE]
            ]
            board = Board.new(random_grid)
            result = [
                board.pieces_placed,
                board.size,
                board.grid
            ]
            expected_pieces_placed = 7
            expected_grid = random_grid
            expected = [7, 3, random_grid]
            expect(result).to eq(expected)
        end
    end

    describe 'is_placeable?()' do
        it 'returns false when called with coordinates containing nil' do
            board = Board.new
            expect(board.is_placeable?(0, nil)).to eq(false)
        end

        it 'returns false when called with coordinates containing a string' do
            board = Board.new
            expect(board.is_placeable?("0", 0)).to eq(false)
        end

        it 'returns false when called with out-of-bounds coordinates' do
            board = Board.new
            expect(board.is_placeable?(0, 3)).to eq(false)
        end

        it "returns false when called on an X-piece occupied cell in the grid" do
            grid = [
                [Piece.EMPTY, Piece.CIRCLE, Piece.CROSS],
                [Piece.CROSS, Piece.CROSS, Piece.CROSS],
                [Piece.CIRCLE, Piece.EMPTY, Piece.CIRCLE]
            ]
            board = Board.new(grid)
            expect(board.is_placeable?(1, 1)).to eq(false)
        end

        it "returns false when called on an O-piece occupied cell in the grid" do
            grid = [
                [Piece.EMPTY, Piece.CIRCLE, Piece.CROSS],
                [Piece.CROSS, Piece.CROSS, Piece.CROSS],
                [Piece.CIRCLE, Piece.EMPTY, Piece.CIRCLE]
            ]
            board = Board.new(grid)
            expect(board.is_placeable?(0, 1)).to eq(false)
        end

        it 'returns true when called on an empty cell in the grid' do
            board = Board.new
            expect(board.is_placeable?(1, 1)).to eq(true)
        end
    end

    describe 'place()' do
        it 'works when called with on any in-bound cell with an X-piece' do
            board = Board.new
            expect(board.grid[1][1] == Piece.EMPTY).to eq(true)

            board.place(1, 1, Piece.CROSS)
            expect(board.grid[1][1] == Piece.CROSS).to eq(true)
        end

        it 'works when called with on any in-bound cell with an O-piece' do
            board = Board.new
            expect(board.grid[1][1] == Piece.EMPTY).to eq(true)

            board.place(1, 1, Piece.CIRCLE)
            expect(board.grid[1][1] == Piece.CIRCLE).to eq(true)
        end
    end

    describe 'meets_min_win_condition?()' do
        it 'returns false if grid has no pieces' do
            board = Board.new
            expect(board.meets_min_win_condition?).to eq(false)
        end

        it "returns false if grid has size * 2 - 2 pieces" do
            grid = [
                [Piece.EMPTY, Piece.CIRCLE, Piece.CROSS],
                [Piece.CROSS, Piece.CIRCLE, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            board = Board.new(grid)
            expect(board.meets_min_win_condition?).to eq(false)
        end

        it "returns true if grid has at least size * 2 - 1 pieces" do
            grid = [
                [Piece.EMPTY, Piece.CIRCLE, Piece.CROSS],
                [Piece.CROSS, Piece.CROSS, Piece.CIRCLE],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            board = Board.new(grid)
            expect(board.meets_min_win_condition?).to eq(true)
        end
    end

    describe "is_full?()" do
        it "returns false if grid has no pieces" do
            board = Board.new
            expect(board.is_full?).to eq(false)
        end

        it "returns true if all of a grid's cells are occupied by non-empty pieces" do
            grid = [
                [Piece.CIRCLE, Piece.CIRCLE, Piece.CROSS],
                [Piece.CROSS, Piece.CROSS, Piece.CIRCLE],
                [Piece.CIRCLE, Piece.CROSS, Piece.CROSS]
            ]
            board = Board.new(grid)
            expect(board.is_full?).to eq(true)
        end
    end

    describe "did_win_rows?()" do
        it "returns false if called on a certain grid with 2 placed pieces" do
            grid = [
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.CROSS, Piece.CROSS, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            board = Board.new(grid)
            expect(board.did_win_rows?(Piece.CROSS)).to eq(false)
        end

        it "returns true if called on a certain grid with 3 placed pieces" do
            grid = [
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.CIRCLE, Piece.CIRCLE, Piece.CIRCLE],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            board = Board.new(grid)
            expect(board.did_win_rows?(Piece.CIRCLE)).to eq(true)
        end
    end

    describe "did_win_cols?()" do
        it "returns false if called on a certain grid with 2 placed pieces" do
            grid = [
                [Piece.EMPTY, Piece.CROSS, Piece.EMPTY],
                [Piece.EMPTY, Piece.CROSS, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            board = Board.new(grid)
            expect(board.did_win_cols?(Piece.CROSS)).to eq(false)
        end

        it "returns true if called on a certain grid with 3 placed pieces" do
            grid = [
                [Piece.EMPTY, Piece.CIRCLE, Piece.EMPTY],
                [Piece.EMPTY, Piece.CIRCLE, Piece.EMPTY],
                [Piece.EMPTY, Piece.CIRCLE, Piece.EMPTY]
            ]
            board = Board.new(grid)
            expect(board.did_win_cols?(Piece.CIRCLE)).to eq(true)
        end
    end

    describe "did_win_pos_diag?()" do
        it "returns false if called on a certain grid with 2 placed pieces" do
            grid = [
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.CROSS, Piece.EMPTY],
                [Piece.CROSS, Piece.EMPTY, Piece.EMPTY]
            ]
            board = Board.new(grid)
            expect(board.did_win_pos_diag?(Piece.CROSS)).to eq(false)
        end

        it "returns true if called on a certain grid with 3 placed pieces" do
            grid = [
                [Piece.EMPTY, Piece.EMPTY, Piece.CIRCLE],
                [Piece.EMPTY, Piece.CIRCLE, Piece.EMPTY],
                [Piece.CIRCLE, Piece.EMPTY, Piece.EMPTY]
            ]
            board = Board.new(grid)
            expect(board.did_win_pos_diag?(Piece.CIRCLE)).to eq(true)
        end
    end

    describe "did_win_neg_diag?()" do
        it "returns false if called on a certain grid with 2 placed pieces" do
            grid = [
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.CROSS, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.CROSS]
            ]
            board = Board.new(grid)
            expect(board.did_win_neg_diag?(Piece.CROSS)).to eq(false)
        end

        it "returns true if called on a certain grid with 3 placed pieces" do
            grid = [
                [Piece.CIRCLE, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.CIRCLE, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.CIRCLE]
            ]
            board = Board.new(grid)
            expect(board.did_win_neg_diag?(Piece.CIRCLE)).to eq(true)
        end
    end

    describe "did_win?()" do
        it "returns false if called on a certain grid with 3 placed pieces" do
            grid = [
                [Piece.EMPTY, Piece.CIRCLE, Piece.EMPTY],
                [Piece.EMPTY, Piece.CROSS, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.CROSS]
            ]
            board = Board.new(grid)
            expect(board.did_win?(Piece.CROSS)).to eq(false)
        end

        it "returns true if called on a certain grid with 6 placed pieces" do
            grid = [
                [Piece.CIRCLE, Piece.CROSS, Piece.CROSS],
                [Piece.EMPTY, Piece.CIRCLE, Piece.CROSS],
                [Piece.EMPTY, Piece.EMPTY, Piece.CIRCLE]
            ]
            board = Board.new(grid)
            expect(board.did_win_neg_diag?(Piece.CIRCLE)).to eq(true)
        end
    end
end
