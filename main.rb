require_relative 'lib/tree'
array = Array.new(15) { rand(0..100) }
array << 59
p array.sort.uniq
tree = Tree.new(array)
tree.pretty_print

puts tree.include?(20)
puts tree.include?(59)
puts tree.include?(49)
