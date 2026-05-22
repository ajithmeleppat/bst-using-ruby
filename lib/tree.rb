# frozen_string_literal: true

require_relative 'node'
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

    parent, node = get_node(value)
    children = number_of_children(node)
    handle_children(parent, node, children)
  end

  private

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
    [parent, node]
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

  def handle_children(parent, node, children)
    if children.zero?
      delete_leaf(parent, node)
    elsif children == 1
      delete_node_with_one_child(parent, node)
    else
      print 'two children'
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
end
