require 'pry'
require_relative 'lib/enumerable'

char_arr = %w[a b c d e f]
word_arr = %w[ant bear cat]
num_arr = [1, 2, 3, 4, 5]

puts '--- my_each ---'
p (char_arr.my_each { |x| print x, ' -- ' }) #=> a -- b -- c -- d -- e -- f --
puts "\n"

puts '--- my_each_with_index ---'
p (char_arr.my_each_with_index { |_x, i| print i, ' -- ' }) #=> 0 -- 1 -- 2 -- 3 -- 4 -- 5 --
puts "\n"

puts '--- my_select ---'
p num_arr.my_select(&:even?) #=> [2, 4]
p (char_arr.my_select { |v| v =~ /[aeiou]/ }) #=> ["a", "e"]
puts "\n"

puts '--- my_all? ---'
p (word_arr.my_all? { |word| word.length >= 3 }) #=> true
p (word_arr.my_all? { |word| word.length >= 4 }) #=> false
p word_arr.my_all?(/t/) #=> false
p [1, 2i, 3.14].my_all?(Numeric) #=> true
p [nil, true, 99].my_all? #=> false
p [].my_all? #=> true
puts "\n"

puts '--- my_map ---'
p (char_arr.my_map { |x| x * 2 }) #=> ["aa", "bb", "cc", "dd", "ee", "ff"]
p ((1..4).my_map { |i| i * i }) #=> [1, 4, 9, 16]
p ([2, 4, 8].my_map { |i| i * i }) #=> [4, 16, 64]
puts "\n"

puts '--- my_any? ---'
p (word_arr.my_any? { |word| word.length >= 3 }) #=> true
p (word_arr.my_any? { |word| word.length >= 4 }) #=> true
p word_arr.my_any?(/d/) #=> false
p [nil, true, 99].my_any?(Integer) #=> true
p [nil, true, 99].my_any? #=> true
p [].my_any? #=> false
puts "\n"

puts '--- my_none? ---'
p (word_arr.my_none? { |word| word.length == 5 }) #=> true
p (word_arr.my_none? { |word| word.length >= 4 }) #=> false
p word_arr.my_none?(/d/) #=> true
p [1, 3.14, 42].my_none?(Float) #=> false
p [].my_none? #=> true
p [nil].my_none? #=> true
p [nil, false].my_none? #=> true
p [nil, false, true].my_none? #=> false
puts "\n"

puts '--- my_count ---'
my_count_arr = [1, 2, 4, 2]
p my_count_arr.my_count #=> 4
p my_count_arr.my_count(2) #=> 2
p my_count_arr.my_count(&:even?) #=> 3
puts "\n"

puts '--- my_inject ---'
p ((5..10).my_inject { |sum, n| sum + n }) #=> 45
p ((5..10).my_inject(1) { |product, n| product * n }) #=> 151200
p ([2, 4, 5].my_inject(1) { |r, i| r * i }) #=> 40
p (word_arr.my_inject { |memo, word| memo.length > word.length ? memo : word }) #=> "bear"
