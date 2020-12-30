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

  describe "#my_all?" do
    it "should work with an empty array" do
      expect([].my_all?).to be_truthy
    end

    it "should return true if all the criterias match in a block" do
      expect(string_arr.my_all? { |ele| ele.length > 1 }).to be_truthy
    end

    it "should return true if all the criterias match with an arg" do
      expect([1, 2i, 3.14].my_all?(Numeric)).to be_truthy
    end

    it "should return false if some of the criterias do not match in a block" do
      expect(string_arr.my_all? { |ele| ele.length > 3 }).to be_falsy
    end

    it "should return false if some of the criterias do not match with an arg" do
      expect(%w[ant bear cat].my_all?(/t/)).to be_falsy
    end
  end

  describe "#my_any?" do
    it "should work with an empty array" do
      expect([].my_any?).to be_falsy
    end

    it "should return true if some of the criterias match in a block" do
      expect(string_arr.my_any? { |ele| ele.length > 1 }).to be_truthy
    end

    it "should return false if none of the elements match with an arg" do
      expect(%w[any bear cale].my_any?(/t/)).to be_falsy
    end
  end

  describe "#my_none?" do
    it "should return true when none of the criterias match with the arg" do
      expect(%w[any bear cale].my_none?(/t/)).to be_truthy
    end

    it "should return true if none of the criterias match in a block" do
      expect(string_arr.my_none? { |ele| ele.length > 10 }).to be_truthy
    end

    it "should filter out the nil values" do
      expect([nil].my_none?).to be_truthy
    end

    it "should work with classes as an arg" do
      expect([1, 3.14, 42].my_none?(Float)).to be_falsy
    end
  end

  describe "my_count" do
    it "should return the result when no block or arg is passed" do
      expect([1, 2, 3].my_count).to eq(3)
    end

    it "should return the result when arg is passed" do
      expect([1, 2, 3, 2].my_count(2)).to eq(2)
    end

    it "should return the result when block is passed" do
      expect([1, 2, 3].my_count(&:even?)).to eq(1)
    end
  end

  describe "#my_map" do
    it "should return an Enumerable if no block is given" do
      expect(arr.my_map).to be_a(Enumerable)
    end

    it "should work with ranges" do
      expect((1..3).my_map { |i| i * i }).to match_array([1, 4, 9])
    end

    it "should work with proc" do
      test_proc = proc { |i| i * i }
      expect((1..3).my_map(test_proc) { |i| i + i } ).to match_array([1, 4, 9])
    end
  end
end
