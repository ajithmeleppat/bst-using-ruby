require_relative 'lib/tree'

array = Array.new(15) { rand(0..100) }
tree = Tree.new(array)

def traversal(tree)
  print 'Inorder: '
  puts(tree.inorder { |value| print "#{value} " })
  print 'Preorder: '
  puts(tree.preorder { |value| print "#{value} " })
  print 'Postorder: '
  puts(tree.postorder { |value| print "#{value} " })
end
puts 'Original tree'
tree.pretty_print
puts tree.balanced? ? 'Tree balanced' : 'Tree is not balanced'
traversal(tree)
tree.insert(100)
tree.insert(110)
tree.insert(120)
puts 'Tree after adding some elements'
tree.pretty_print
puts tree.balanced? ? 'Tree balanced' : 'Tree is not balanced'
tree.rebalance
puts 'Tree after rebalance'
tree.pretty_print
puts tree.balanced? ? 'Tree balanced' : 'Tree is not balanced'
traversal(tree)
