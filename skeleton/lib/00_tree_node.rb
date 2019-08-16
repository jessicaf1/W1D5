require "byebug"

class PolyTreeNode
  attr_accessor :value, :parent, :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end 

  def parent=(node)
    #debugger
      old_parent = self.parent
      if old_parent != nil
        old_parent.children.delete(self)
      end
      @parent = node  
      if self.parent != nil 
      parent.children << self if !node.children.include?(self)
      end      
  end

  def add_child(node)
    node.parent=(self)
  end

  def remove_child(node)
    if node.parent != nil 
     node.parent = nil
    else
      raise "node is not a child"
    end  
  end

  def dfs(target_value)
    
    return self if self.value == target_value
    self.children.each do |child|
      
      node_check = child.dfs(target_value)
      return node_check if !node_check.nil?
    end 
    nil 
  end 

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      el = queue.shift
      return el if el.value == target_value
      el.children.each { |child| queue.push(child) }
    end
  
    nil
  end


end

# node_test = PolyTreeNode.new(7)
# node_test.parent=()
