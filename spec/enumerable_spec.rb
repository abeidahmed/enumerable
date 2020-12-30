require 'rspec'
require_relative '../lib/enumerable'

RSpec.describe Enumerable do
  let(:arr) { [1, 2, 3] }
  let(:range) { (1..5) }
  let(:string_arr) { %w[john doe man] }

  describe "#my_each" do
    it "should return the same array" do
      expect(arr.my_each { |ele| ele }).to match_array(arr)
    end

    it "should iterate a range and return the same array" do
      expect(range.my_each { |ele| ele }).to match_array(range)
    end

    it "should iterate a string array and return the same array" do
      expect(string_arr.my_each { |ele| ele }).to match_array(string_arr)
    end

    it "should return an Enumerable if no block is given" do
      expect(arr.my_each).to be_a(Enumerable)
    end
  end

  describe "#my_each_with_index" do
    it "should iterate over elements and return the result" do
      empty_arr = []
      string_arr.my_each_with_index do |name, idx|
        empty_arr << name if idx.even?
      end

      expect(empty_arr).to match_array(%w[john man])
    end

    it "should return an Enumerable if no block is given" do
      expect(arr.my_each_with_index).to be_a(Enumerable)
    end
  end

  describe "#my_select" do
    it "should filter the array and return appropriate result" do
      expect(arr.my_select { |n| n > 2 }).to match_array([3])
    end

    it "should return an Enumerable if no block is given" do
      expect(arr.my_select).to be_a(Enumerable)
    end
  end
end
