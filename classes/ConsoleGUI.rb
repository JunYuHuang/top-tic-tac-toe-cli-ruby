require 'io/console'

class ConsoleGUI
    def initialize(state = State.new, display = StateToString)
        @state = state
        @display = display
    end

    def clear_screen()
        $stdout.clear_screen
    end

    def is_valid_input?(input)
        input = input.to_s
        if input.length != 3
            return false
        end

        input_as_array = input.split(",")
        if input_as_array.length != 2
            return false
        end

        row, col = input_as_array

        begin
            row = Integer(row)
            col = Integer(col)
        rescue Exception => err
            return false
        else
            return true
        end
    end

    def run_game()
        while true
            break if @state.is_game_over?
            while true
                clear_screen()
                puts(@display.get_board(@state.board.grid))
                puts
                puts(@display.get_turn(@state.turn))
                puts(@display.get_player_prompt(@state.turn))
                position = gets.chomp.to_s
                row, col = position.split(",")
                row = row.to_i - 1
                col = col.to_i - 1
                if (is_valid_input?(position) and
                   @state.board.is_placeable?(row, col))
                   @state.board.place(row, col, @state.turn)
                   break
                end
            end
            @state.set_turn
        end
        clear_screen()
        puts(@display.get_board(@state.board.grid))
        puts
        puts(@display.get_game_end(@state.get_winner))
    end
end
