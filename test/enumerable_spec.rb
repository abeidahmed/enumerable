require 'rspec'
require_relative '../lib/enumerable'

describe "#my_each" do
  let(:arr) { [1, 2, 3] }

  it "should return the same array" do
    expect(arr.my_each { |ele| ele }).to match_array(arr)
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