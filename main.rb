require_relative 'lib/tree'
array = Array.new(15) { rand(0..100) }

p array.sort.uniq
tree = Tree.new(array)
tree.pretty_print
puts tree.include?(59)
tree.insert(59)
puts 'Tree after inserting 59'
tree.pretty_print
puts tree.include?(59)
