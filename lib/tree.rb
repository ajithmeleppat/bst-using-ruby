# frozen_string_literal: true

require_relative 'node'
require 'pry-byebug'

# Represents a binary search tree
class Tree
  def initialize(array)
    array.uniq!
    array.sort!
    @root = build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  def include?(value)
    node = @root
    until node.nil?
      return true if node.value == value

      node = value > node.value ? node.right : node.left
    end
    false
  end

  def insert(value, node = @root)
    return if include?(value)

    if value < node.value
      node.left = Node.new(value) if node.left.nil?
      insert(value, node.left)
    else
      node.right = Node.new(value) if node.right.nil?
      insert(value, node.right)
    end
  end

  def delete(value)
    return nil unless include?(value)

    parent, node, children = get_node(value)
    if children == 2
      delete_node_with_two_children(node)
    elsif children == 1
      delete_node_with_one_child(parent, node)
    else
      delete_leaf(parent, node)
    end
    self
  end

  def depth(value)
    return nil unless include?(value)

    node = @root
    depth = 0
    until node.value == value
      depth += 1
      node = node.value > value ? node.left : node.right
    end
    depth
  end

  def height(value = nil, node = @root)
    return nil unless include?(value)

    node = node.value > value ? node.left : node.right until node.value == value
    calculate_height_at_node(node)
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = calculate_height_at_node(node.left)
    right_height = calculate_height_at_node(node.right)
    return false if left_height - right_height > 1 || right_height - left_height > 1

    return true if balanced?(node.left) && balanced?(node.right)

    false
  end

  def level_order
    return to_enum(:level_order) unless block_given?

    queue = []
    node = @root
    queue << node
    until queue.empty?
      node = queue.shift
      yield node.value
      queue << node.left if node.left
      queue << node.right if node.right
    end
  end

  def inorder(node = @root, &block)
    return to_enum(:inorder, node) unless block_given?
    return nil if node.nil?

    inorder(node.left, &block)
    yield node.value
    inorder(node.right, &block)
  end

  def preorder(node = @root, &block)
    return to_enum(:preorder, node) unless block_given?
    return nil if node.nil?

    yield node.value
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  def postorder(node = @root, &block)
    return to_enum(:postorder, node) unless block_given?
    return nil if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)
    yield node.value
  end

  def rebalance
    array = inorder.to_a
    @root = build_tree(array)
  end

  private

  def calculate_height_at_node(node)
    return -1 if node.nil?

    left = calculate_height_at_node(node.left)
    right = calculate_height_at_node(node.right)
    1 + [left, right].max
  end

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    node = Node.new(array[mid])
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[mid + 1..])
    node
  end

  def get_node(value)
    node = @root
    parent = nil
    until node.value == value
      parent = node
      node = node.value > value ? node.left : node.right
    end
    children = number_of_children(node)
    [parent, node, children]
  end

  def number_of_children(node)
    if node.left.nil? && node.right.nil?
      0
    elsif node.left.nil? || node.right.nil?
      1
    else
      2
    end
  end

  def delete_leaf(parent, node)
    if parent.value > node.value
      parent.left = nil
    else
      parent.right = nil
    end
  end

  def delete_node_with_one_child(parent, node)
    child = node.left.nil? ? node.right : node.left
    if parent.value > node.value
      parent.left = child
    else
      parent.right = child
    end
  end

  def delete_node_with_two_children(node)
    successor = node.right
    parent = node
    while successor.left
      parent = successor
      successor = successor.left
    end
    node.value = successor.value
    if parent == node
      node.right = successor.right
    else
      parent.left = successor.right
    end
  end
end
