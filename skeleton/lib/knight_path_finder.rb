require_relative "00_tree_node"

class KnightPathFinder

  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    build_move_tree
  end

  def self.valid_moves(pos) #[1,2]
    right_space = pos[0]
    left_space = pos[1]
    moves_arr = []
    moves_arr << [right_space + 2, left_space + 1]
    moves_arr << [right_space + 2, left_space - 1]
    moves_arr << [right_space + 1, left_space + 2]
    moves_arr << [right_space + 1, left_space - 2]
    moves_arr << [right_space - 2, left_space + 1]
    moves_arr << [right_space - 2, left_space - 1]
    moves_arr << [right_space -1, left_space + 2]
    moves_arr << [right_space -1, left_space - 2]
    return moves_arr.select do |pos_2|
      pos_2[0].between?(0,7) && pos_2[1].between?(0,7)
    end
  end

  def build_move_tree
    @considered_positions = [@root_node.value]
    start_pos = @root_node.value 
    moves_q = [start_pos]
    prev_node = @root_node

    until moves_q.empty?
      moves_q += self.new_move_positions(start_pos)
      
      start_pos = moves_q.shift
      new_node = PolyTreeNode.new(start_pos)
      new_node.add_parent(prev_node)
      
    end
    
    moves_q

  end

  def new_move_positions(pos)
    
    valid_positions = KnightPathFinder.valid_moves(pos).select do |new_pos|
      !@considered_positions.include?(new_pos)
    end

    @considered_positions.concat(valid_positions)
    return valid_positions
  end


end


if $PROGRAM_NAME == __FILE__
  kpf = KnightPathFinder.new([0,0])
  # p KnightPathFinder.valid_moves([4,4])
  p kpf.build_move_tree
end