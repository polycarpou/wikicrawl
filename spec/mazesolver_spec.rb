require_relative 'spec_helper.rb'
require_relative '../mazesolver.rb'


small_maze = [
[" "," ","█"," "," "],
[" "," "," "," ","█"],
[" ","█","█","█","█"],
[" ","♥"," "," "," "],
[" "," "," ","█"," "]
]

describe MazeSolver do
  let(:new_maze) { MazeSolver.new(small_maze) }  
  context "#new(maze)" do
    it "instantiates a new maze without errors" do   
      expect(new_maze.maze).to eq(small_maze)
    end
  end
    
  context "#neighbours(node)" do
	  it "should return all neighbours (coordinates above, below, left and right of input)" do
	   new_maze.neighbours([2,2]).sort.should == [[2,1],[1,2],[2,3],[3,2]].sort
     new_maze.neighbours([2,2]).count.should == 4
	  end

    it "should only return neighbours that are in the maze boundary" do
     new_maze.neighbours([0,2]).sort.should == [[1,2],[0,3],[0,1]].sort
     new_maze.neighbours([0,2]).count.should == 3

     new_maze.neighbours([4,4]).sort.should == [[3,4],[4,3]].sort
     new_maze.neighbours([4,4]).count.should == 2
    end
  end

  context "#blocked?(node)" do
    it "returns true if coordinate contains a '█' else false" do
      new_maze.blocked?([1,1]).should eq(false)
      new_maze.blocked?([2,2]).should eq(true)
    end
  end

  context "#setup_arrays" do
    it "the backpath, visited set and the queue should all be set to []" do
      new_maze.setup_arrays
      new_maze.path.should == []
      new_maze.set.should == []
      new_maze.queue.should == []
    end
  end

  context "#add_to_arrays(node, previous_node)" do
    it "adds the current location to the queue, set, path arrays and the previous location to the path array. Previous node on path has a default of 'start'" do
      new_maze.setup_arrays
      
      current_node = [2,1]
      new_maze.add_to_arrays(current_node)
      new_maze.path.should == [[[2,1],'start']]
      new_maze.set.should == [[2,1]]
      new_maze.queue.should == [[2,1]]

      current_node = [1,1]
      previous_node = [2,1]
      new_maze.add_to_arrays(current_node,previous_node)
      new_maze.path.should == [[[2,1],'start'], [[1,1],[2,1]]]
      new_maze.set.should == [[2,1],[1,1]]
      new_maze.queue.should == [[2,1],[1,1]]

      current_node = [0,1]
      previous_node = [1,1]

      new_maze.add_to_arrays(current_node,previous_node)
      new_maze.path.should == [[[2,1],'start'], [[1,1],[2,1]], [[0,1],[1,1]]]
      new_maze.set.should == [[2,1], [1,1], [0,1]]
      new_maze.queue.should == [[2,1], [1,1], [0,1]] 
    end
  end

  context "#find_previous(node)" do
    it "finds the node in the path array and returns the previous node" do
      new_maze.path = [[[2,1],'start']]
      new_maze.find_previous([2,1]).should == 'start'

      new_maze.path = [[[2,1],'start'], [[1,1],[2,1]], [[0,1],[1,1]]]
      new_maze.find_previous([1,1]).should == [2,1]

      
      new_maze.path = [[[2,1],'start'], [[1,1],[2,1]], [[0,1],[1,1]]]
      new_maze.find_previous([0,1]).should == [1,1]
    end
  end

  context "#backtrack(node)" do
    it "finds all of the previous nodes until it reaches the 'start'" do
      new_maze.path = [[[2,1],'start'], [[1,1],[2,1]], [[0,1],[1,1]]]
      new_maze.backtrack([0,1]).should == [[1,1], [2,1], 'start']
    end
  end

  context "#bfs(starting_node, looking_for" do
    it "implements the breadth first search algorithm and once it finds what its 'looking_for' it returns the backpath" do
      new_maze.bfs([0,0], '♥').should == [[0,0], [0,1], [0,2], [0,3]]
      new_maze.bfs([4,0], '♥').should == [[4,0], [3,0], [3,1], [2,1], [1,1], [0,1], [0,2], [0,3]]
    end
  end
end 

