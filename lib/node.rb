# frozen_string_literal: true

# Represents a single node in the tree
class Node
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    self.value = value
    self.left = left
    self.right = right
  end
end
