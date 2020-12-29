require 'pry'
require_relative 'lib/enumerable'

char_arr = %w[a b c d e f]
word_arr = %w[ant bear cat]
num_arr = [1, 2, 3, 4, 5]

puts '--- my_each ---'
char_arr.my_each { |x| print x, ' -- ' }  #=> a -- b -- c -- d -- e -- f --
puts "\n"

puts '--- my_each_with_index ---'
char_arr.my_each_with_index { |x, i| print i, ' -- ' } #=> 0 -- 1 -- 2 -- 3 -- 4 -- 5 --
puts "\n"