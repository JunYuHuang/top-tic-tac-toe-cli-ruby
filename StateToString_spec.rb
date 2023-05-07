require_relative 'spec_helper'
require_relative 'index'

RSpec.describe 'StateToString' do
    describe 'get_board()' do
        it "renders an empty board correctly" do
            state = State.new
            result = StateToString.get_board(state.board.grid)
            expected = [
                "  1 2 3\n",
                "1      \n",
                "2      \n",
                "3      \n"
            ].join
            expect(result).to eq(expected)
        end

        it "renders a board with 5 pieces correctly" do
            grid = [
                [Piece.CROSS, Piece.CROSS, Piece.CROSS],
                [Piece.CIRCLE, Piece.EMPTY, Piece.CROSS],
                [Piece.EMPTY, Piece.CIRCLE, Piece.CIRCLE]
            ]
            state = State.new(Board.new(grid))
            result = StateToString.get_board(state.board.grid)
            expected = [
                "  1 2 3\n",
                "1 X X X\n",
                "2 O   X\n",
                "3   O O\n"
            ].join
            expect(result).to eq(expected)
        end
    end

    describe 'get_turn()' do
        it "renders the right turn at the start of the game" do
            state = State.new
            result = StateToString.get_turn(state.turn)
            expected = "It is player X's turn."
            expect(result).to eq(expected)
        end

        it "renders the right turn if O-piece player goes first" do
            state = State.new(Board.new, Piece.CIRCLE)
            result = StateToString.get_turn(state.turn)
            expected = "It is player O's turn."
            expect(result).to eq(expected)
        end
    end
end
