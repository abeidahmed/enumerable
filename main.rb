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

puts '--- my_select ---'
p num_arr.my_select { |num|  num.even?  }   #=> [2, 4]
p char_arr.my_select { |v| v =~ /[aeiou]/ } #=> ["a", "e"]
puts "\n"

puts '--- my_all? ---'
p word_arr.my_all? { |word| word.length >= 3 } #=> true
p word_arr.my_all? { |word| word.length >= 4 } #=> false
p word_arr.my_all?(/t/)                        #=> false
p [1, 2i, 3.14].my_all?(Numeric)               #=> true
p [nil, true, 99].my_all?                      #=> false
p [].my_all?                                   #=> true
puts "\n"

puts '--- my_map ---'
p char_arr.my_map { |x| x * 2 } #=> ["aa", "bb", "cc", "dd", "ee", "ff"]
puts "\n"

puts '--- my_any? ---'
p word_arr.my_any? { |word| word.length >= 3 } #=> true
p word_arr.my_any? { |word| word.length >= 4 } #=> true
p word_arr.my_any?(/d/)                        #=> false
p [nil, true, 99].my_any?(Integer)             #=> true
p [nil, true, 99].my_any?                      #=> true
p [].my_any?                                   #=> false
puts "\n"