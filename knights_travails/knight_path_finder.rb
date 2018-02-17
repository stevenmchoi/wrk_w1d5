require_relative '../poly_tree_node/skeleton/lib/00_tree_node'

class KnightPathFinder
  attr_reader :start_pos, :visited_pos

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_pos = [start_pos]
  end

  def self.valid_moves(pos) # [3,3]
    key = [1, 2]
    pos_arr = []

    4.times do
      pos_arr << KnightPathFinder.add_array(pos, key) # [[4,5]] ; [[4,5], [2,5], [5,2]]
      row, col = key # [1,2] ; [2,-1] ; [-1,-2] ; [-2,1]
      row = -row # 1 => -1 ; 2 => -2
      key = [row, col] # [-1,2] ; [-2,-1] ; [1,-2] ; [2,1]
      pos_arr << KnightPathFinder.add_array(pos, key) # [[4,5], [2,5], [5,2], [1, 2]]
      key = [col, row] # [-1,2] => [2,-1]
    end

    pos_arr.select do |position|
      position[0].between?(0, 7) && position[1].between?(0, 7)
    end
  end

  def new_move_positions(pos)
    pos_arr = KnightPathFinder.valid_moves(pos)
    pos_arr.reject { |position| visited_pos.include?(position) }
  end

  def build_move_tree
    start_node = PolyTreeNode.new(start_pos)
    queue = [start_node]

    until queue.empty?
      new_node = queue.shift
      valid_pos = new_move_positions(new_node)
      children = valid_pos.map do |pos|
        child = PolyTreeNode.new(pos)
        queue << child
        child
      end

      children.each { |child| new_node.add_child(child) }
    end

  end

  private
  def self.add_array(arr1, arr2)
    [arr1,arr2].transpose.map { |col| col.reduce(:+)}
  end
end
