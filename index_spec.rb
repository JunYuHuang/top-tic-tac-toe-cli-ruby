require_relative 'spec_helper'
require_relative 'index'

RSpec.describe 'Board' do
    describe 'initialise()' do
        it 'returns a blank grid when called with no parameters' do
            empty_board = Board.new
            result = [
                empty_board.pieces_placed,
                empty_board.size,
                empty_board.grid
            ]
            expected_grid = [
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            expected = [0, 3, expected_grid]
            expect(result).to eq(expected)
        end

        it 'returns a non-empty grid when called with a custom non-empty 2D array' do
            random_grid = [
                [Piece.EMPTY, Piece.CIRCLE, Piece.CROSS],
                [Piece.CROSS, Piece.CROSS, Piece.CROSS],
                [Piece.CIRCLE, Piece.EMPTY, Piece.CIRCLE]
            ]
            custom_board = Board.new(random_grid)
            result = [
                custom_board.pieces_placed,
                custom_board.size,
                custom_board.grid
            ]
            expected_pieces_placed = 7
            expected_grid = random_grid
            expected = [7, 3, random_grid]
            expect(result).to eq(expected)
        end


    end
end
