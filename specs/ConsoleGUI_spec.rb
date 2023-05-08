require_relative 'spec_helper'
require_relative '../classes/Piece'
require_relative '../classes/Board'
require_relative '../classes/State'
require_relative '../classes/StateToString'
require_relative '../classes/ConsoleGUI'

RSpec.describe 'ConsoleGUI' do
    describe 'is_valid_input?()' do
        it "returns false if called with an empty string" do
            console = ConsoleGUI.new
            result = console.is_valid_input?("")
            expect(result).to eq(false)
        end

        it "returns false if called with nil" do
            console = ConsoleGUI.new
            result = console.is_valid_input?(nil)
            expect(result).to eq(false)
        end

        it "returns false if called with a string of length 3 without the comma delimiter" do
            console = ConsoleGUI.new
            result = console.is_valid_input?(" a ")
            expect(result).to eq(false)
        end

        it "returns false if called with a string of length 3 with a non-1-digit integer character" do
            console = ConsoleGUI.new
            result = console.is_valid_input?("0,a")
            expect(result).to eq(false)
        end

        it "returns true if called with a string of length 3 with 2 1-digit integers" do
            console = ConsoleGUI.new
            result = console.is_valid_input?("0,0")
            expect(result).to eq(true)
        end
    end
end
