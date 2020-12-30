require 'rspec'
require_relative '../lib/enumerable'

describe "#my_each" do
  let(:arr) { [1, 2, 3] }
  let(:range) { (1..5) }
  let(:string_arr) { %w[john doe man] }

  it "should return the same array" do
    expect(arr.my_each { |ele| ele }).to match_array(arr)
  end

  it "should iterate a range and return the same array" do
    expect(range.my_each { |ele| ele }).to match_array(range)
  end

  it "should iterate a string array and return the same array" do
    expect(string_arr.my_each { |ele| ele }).to match_array(string_arr)
  end
end

describe "#my_select" do
  let(:arr) { [1, 2, 3] }

  it "should filter the array and return appropriate result" do
    expect(arr.my_select { |n| n > 2 }).to match_array([3])
  end

  it "should return an Enumerable if no block is given" do
    expect(arr.my_select).to be_a(Enumerable)
  end
end