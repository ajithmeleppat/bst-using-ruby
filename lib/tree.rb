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

    if node.left.nil? && node.value > value
      node.left = Node.new(value)
      nil
    elsif node.right.nil? && node.value < value
      node.right = Node.new(value)
      nil
    elsif node.value > value
      insert(value, node.left)
    else
      insert(value, node.right)
    end
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
end
