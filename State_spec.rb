require_relative 'spec_helper'
require_relative 'index'

RSpec.describe 'State' do
    describe 'initialize()' do
        it 'works' do
            state = State.new
            result = [state.board.grid, state.turn]
            expected_grid = [
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            expected = [expected_grid, Piece.CROSS]
            expect(result).to eq(expected)
        end
    end

    describe 'set_turn()' do
        it "sets next turn to O-piece player's if current turn is X-piece player's" do
            state = State.new
            expect(state.turn).to eq(Piece.CROSS)

            state.set_turn
            expect(state.turn).to eq(Piece.CIRCLE)
        end

        it "sets next turn to X-piece player's if current turn is O-piece player's" do
            state = State.new(Board.new, Piece.CIRCLE)
            expect(state.turn).to eq(Piece.CIRCLE)

            state.set_turn
            expect(state.turn).to eq(Piece.CROSS)
        end
    end

    describe 'is_game_over?()' do
        it "returns false for a certain Board state with 0 placed pieces" do
            state = State.new
            expect(state.is_game_over?).to eq(false)
        end

        it "returns false for a certain Board state with 4 placed pieces" do
            grid = [
                [Piece.CIRCLE, Piece.CROSS, Piece.EMPTY],
                [Piece.CROSS, Piece.CIRCLE, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            state = State.new(Board.new(grid))
            expect(state.is_game_over?).to eq(false)
        end

        it "returns false for a certain Board state with 5 placed pieces" do
            grid = [
                [Piece.CIRCLE, Piece.CROSS, Piece.EMPTY],
                [Piece.CROSS, Piece.CIRCLE, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.CROSS]
            ]
            state = State.new(Board.new(grid))
            expect(state.is_game_over?).to eq(false)
        end

        it "returns true for a certain Board state with 5 placed pieces" do
            grid = [
                [Piece.CIRCLE, Piece.CROSS, Piece.EMPTY],
                [Piece.CIRCLE, Piece.CROSS, Piece.EMPTY],
                [Piece.EMPTY, Piece.CROSS, Piece.EMPTY]
            ]
            state = State.new(Board.new(grid))
            expect(state.is_game_over?).to eq(true)
        end

        it "returns true for a certain Board state with 7 placed pieces" do
            grid = [
                [Piece.CROSS, Piece.CROSS, Piece.CROSS],
                [Piece.CIRCLE, Piece.EMPTY, Piece.CROSS],
                [Piece.EMPTY, Piece.CIRCLE, Piece.CIRCLE]
            ]
            state = State.new(Board.new(grid))
            expect(state.is_game_over?).to eq(true)
        end

        it "returns true for a certain Board state with 9 placed pieces" do
            grid = [
                [Piece.CIRCLE, Piece.CROSS, Piece.CROSS],
                [Piece.CROSS, Piece.CIRCLE, Piece.CIRCLE],
                [Piece.CROSS, Piece.CIRCLE, Piece.CROSS]
            ]
            state = State.new(Board.new(grid))
            expect(state.is_game_over?).to eq(true)
        end
    end

    describe "set_board()" do
        it "returns false and does not update State.board if called with invalid coordinates (nil value)" do
            state = State.new
            expect(state.set_board(0, nil)).to eq(false)
            expect(state.board.pieces_placed).to eq(0)
        end

        it "returns false and does not update State.board if called with invalid coordinates (non-empty cell)" do
            grid = [
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.CROSS, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            state = State.new(Board.new(grid))
            expect(state.set_board(1, 1)).to eq(false)
            expect(state.board.pieces_placed).to eq(1)
        end

        it "returns true and updates State.board if called with valid coordinates" do
            grid = [
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY],
                [Piece.CROSS, Piece.EMPTY, Piece.EMPTY],
                [Piece.EMPTY, Piece.EMPTY, Piece.EMPTY]
            ]
            state = State.new(Board.new(grid))
            expect(state.set_board(1, 1)).to eq(true)
            expect(state.board.pieces_placed).to eq(2)
        end
    end

    describe 'get_winner()' do
        it "returns nil for a certain Board state with 0 placed pieces" do
            state = State.new
            expect(state.get_winner).to eq(nil)
        end

        it "returns nil for a certain Board state with 7 placed pieces" do
            grid = [
                [Piece.CIRCLE, Piece.CROSS, Piece.CROSS],
                [Piece.CROSS, Piece.CIRCLE, Piece.CIRCLE],
                [Piece.EMPTY, Piece.EMPTY, Piece.CROSS]
            ]
            state = State.new(Board.new(grid))
            expect(state.get_winner).to eq(nil)
        end

        it "returns Piece.CIRCLE for a certain Board state with 7 placed pieces" do
            grid = [
                [Piece.CROSS, Piece.CIRCLE, Piece.EMPTY],
                [Piece.CROSS, Piece.CIRCLE, Piece.CROSS],
                [Piece.EMPTY, Piece.CIRCLE, Piece.CROSS]
            ]
            state = State.new(Board.new(grid))
            expect(state.get_winner).to eq(Piece.CIRCLE)
        end

        it "returns Piece.CROSS for a certain Board state with 7 placed pieces" do
            grid = [
                [Piece.CROSS, Piece.CROSS, Piece.CROSS],
                [Piece.CIRCLE, Piece.EMPTY, Piece.CROSS],
                [Piece.EMPTY, Piece.CIRCLE, Piece.CIRCLE]
            ]
            state = State.new(Board.new(grid))
            expect(state.get_winner).to eq(Piece.CROSS)
        end

        it "returns Piece.EMPTY (representing a tie) for a certain Board state with 9 placed pieces" do
            grid = [
                [Piece.CIRCLE, Piece.CROSS, Piece.CROSS],
                [Piece.CROSS, Piece.CIRCLE, Piece.CIRCLE],
                [Piece.CIRCLE, Piece.CROSS, Piece.CROSS]
            ]
            state = State.new(Board.new(grid))
            expect(state.get_winner).to eq(Piece.EMPTY)
        end
    end
end
