require_relative 'spec_helper'
require_relative 'index'

RSpec.describe 'stock_picker()' do
    it "returns [1,4] when called with [17,3,6,9,15,8,6,1,10]" do
        exp = stock_picker([17,3,6,9,15,8,6,1,10])
        res = [1,4]
        expect(exp).to eq(res)
    end

    it "returns [1,4] when called with [7,1,5,3,6,4]" do
        exp = stock_picker([7,1,5,3,6,4])
        res = [1,4]
        expect(exp).to eq(res)
    end

    it "returns [-1,-1] when called with [7,6,4,3,1]" do
        exp = stock_picker([7,6,4,3,1])
        res = [-1,-1]
        expect(exp).to eq(res)
    end

    it "returns [-1,-1] when called with [1]" do
        exp = stock_picker([1])
        res = [-1,-1]
        expect(exp).to eq(res)
    end
end

