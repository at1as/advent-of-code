input = File.open("./input.txt", "r").readlines().map do |line| 
  # Name, Weight, Children
  [
    line.split(" ", 3)[0],
    line.split(" ", 3)[1]&.gsub(/\(|\)/, ""),
    line.split(" ", 3)[2]&.gsub("->", "").split(",").map(&:strip)
  ]
end

class Node
  @@nodes = []

  attr_reader :node_name, :children
  def initialize(node_name, weight, children = [])
    # Name is a unique ID
    return if Node.find(node_name)

    @node_name = node_name
    @weight = weight
    @children = children

    @@nodes << self
  end

  def self.find(node_name)
    @@nodes.find { |node| node.node_name == name }
  end

  def self.size
    @@nodes.length
  end

  def self.parent_of(node_name)
    @@nodes.find { |node| node.children.include? node_name }
  end

  def self.random
    @@nodes.sample
  end
end

input.each do |node|
  name, weight, children = node
  Node.new(name, weight, children)
end

current_node = Node.random
loop do
  next_node = Node.parent_of(current_node.node_name)
  
  if next_node.nil?
    break
  else
    current_node = next_node
  end
end

puts current_node.node_name
