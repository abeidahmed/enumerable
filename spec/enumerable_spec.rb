require 'rspec'
require_relative '../lib/enumerable'

# rubocop:disable Metrics/BlockLength
RSpec.describe Enumerable do
  describe '#my_each' do
    let(:arr) { [1, 2, 3] }
    let(:range) { (1..5) }

    it 'should return the same array' do
      expect(arr.my_each { |ele| ele }).to match_array(arr)
    end

    it 'should iterate a range and return the same array' do
      expect(range.my_each { |ele| ele }).to match_array(range)
    end

    it 'should iterate a string array and return the same array' do
      string_arr = %w[john doe man]

      expect(string_arr.my_each { |ele| ele }).to match_array(string_arr)
    end

    it 'should return self when block is not given' do
      block = proc { |i| i }
      expect(range.my_each(&block)).to eq(range.each(&block))
    end

    it 'should return an Enumerable if no block is given' do
      expect(arr.my_each).to be_a(Enumerable)
    end
  end

  describe '#my_each_with_index' do
    let(:range) { (1..3) }

    it 'should iterate over elements and return the result' do
      empty_arr = []
      %w[john doe man].my_each_with_index do |name, idx|
        empty_arr << name if idx.even?
      end

      expect(empty_arr).to match_array(%w[john man])
    end

    it 'should work with ranges' do
      expect(range.my_each_with_index { |_num, idx| idx }).to match_array(
        [1, 2, 3]
      )
    end

    it 'should return self when block is not given' do
      block = proc { |i| i }
      expect(range.my_each_with_index(&block)).to eq(
        range.each_with_index(&block)
      )
    end

    it 'should return an Enumerable if no block is given' do
      expect([1, 2, 3].my_each_with_index).to be_a(Enumerable)
    end
  end

  describe '#my_select' do
    let(:arr) { [1, 2, 3] }

    it 'should filter the array and return appropriate result' do
      expect(arr.my_select { |n| n > 2 }).to match_array([3])
    end

    it 'should return an Enumerable if no block is given' do
      expect(arr.my_select).to be_a(Enumerable)
    end
  end

  describe '#my_all?' do
    let(:string_arr) { %w[john doe mat] }

    it 'should work with an empty array' do
      expect([].my_all?).to be_truthy
    end

    it 'should return true if all the criterias match in a block' do
      expect(string_arr.my_all? { |ele| ele.length > 1 }).to be_truthy
    end

    it 'should return true if all the criterias match with an arg' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to be_truthy
    end

    it 'should return false if some of the criterias do not match in a block' do
      expect(string_arr.my_all? { |ele| ele.length > 3 }).to be_falsy
    end

    it 'should return false if some of the criterias do not match with an arg' do
      expect(string_arr.my_all?(/t/)).to be_falsy
    end
  end

  describe '#my_any?' do
    let(:string_arr) { %w[john doe man] }

    it 'should work with an empty array' do
      expect([].my_any?).to be_falsy
    end

    it 'should return true if some of the criterias match in a block' do
      expect(string_arr.my_any? { |ele| ele.length > 1 }).to be_truthy
    end

    it 'should return false if none of the elements match with an arg' do
      expect(string_arr.my_any?(/t/)).to be_falsy
    end
  end

  describe '#my_none?' do
    let(:string_arr) { %w[john doe man] }

    it 'should return true when none of the criterias match with the arg' do
      expect(string_arr.my_none?(/t/)).to be_truthy
    end

    it 'should return true if none of the criterias match in a block' do
      expect(string_arr.my_none? { |ele| ele.length > 10 }).to be_truthy
    end

    it 'should filter out the nil values' do
      expect([nil].my_none?).to be_truthy
    end

    it 'should work with classes as an arg' do
      expect([1, 3.14, 42].my_none?(Float)).to be_falsy
    end
  end

  describe '#my_count' do
    let(:arr) { [1, 2, 3, 2] }

    it 'should return the result when no block or arg is passed' do
      expect(arr.my_count).to eq(4)
    end

    it 'should return the result when arg is passed' do
      expect(arr.my_count(2)).to eq(2)
    end

    it 'should return the result when block is passed' do
      expect(arr.my_count(&:even?)).to eq(2)
    end
  end

  describe '#my_map' do
    let(:range) { (1..3) }

    it 'should return an Enumerable if no block is given' do
      expect([1, 2, 3].my_map).to be_a(Enumerable)
    end

    it 'should work with ranges' do
      expect(range.my_map { |i| i * i }).to match_array([1, 4, 9])
    end

    it 'should work with proc' do
      test_proc = proc { |i| i * i }
      expect(range.my_map(&test_proc)).to match_array([1, 4, 9])
    end
  end

  describe '#my_inject' do
    let(:range) { (1..5) }

    it 'should work with blocks' do
      expect(range.my_inject { |sum, n| sum + n }).to eq(15)
    end

    it 'should work with a combination of block and arg' do
      expect(range.my_inject(1) { |product, n| product * n }).to eq(120)
    end

    it 'should work with initial value and symbol passed as an arg' do
      expect(range.my_inject(1, :+)).to eq(16)
    end

    it 'should work with block' do
      longest =
        %w[ant bear cat].my_inject do |memo, word|
          memo.length > word.length ? memo : word
        end

      expect(longest).to eq('bear')
    end

    it 'should work with the given multiply_els method' do
      expect(multiply_els([2, 4, 5])).to eq(40)
    end
  end
end
# rubocop:enable Metrics/BlockLength
