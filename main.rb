require_relative 'lib/tree'
# array = Array.new(15) { rand(0..100) }
array = [10, 20, 30, 40, 50, 60, 70, 80, 90]
tree = Tree.new(array)
tree.pretty_print
puts 'deleting a leaf node'
tree.delete(10)
tree.pretty_print
puts 'deleting a node with one child'
tree.delete(70)
tree.pretty_print
