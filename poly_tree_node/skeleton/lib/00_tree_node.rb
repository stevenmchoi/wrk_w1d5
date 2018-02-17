class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node_obj)
    if node_obj && @parent.nil?
      @parent = node_obj
      node_obj.children << self unless node_obj.children.include?(self)
    elsif node_obj && @parent
      @parent.children.delete(self)
      @parent = node_obj
      node_obj.children << self unless node_obj.children.include?(self)
    elsif node_obj.nil? && @parent
      @parent.children.delete(self)
      @parent = node_obj
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if self.children.include?(child_node)
      child_node.parent = nil
      self.children.delete(child_node)
    else
      raise "No a child of this node"
    end
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      result = child.dfs(target_value)
      if result
        return result
      end
    end
    nil
  end

  def bfs(target_value)
    queue = []

    queue << self

    until queue.empty?
      next_node = queue.shift
      if next_node.value == target_value
        return next_node
      elsif !next_node.children.empty?
        queue.concat(next_node.children)
      end
    end

  end

end
