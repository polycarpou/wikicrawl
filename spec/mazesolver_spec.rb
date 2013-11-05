require_relative 'spec_helper.rb'
require_relative 'mazesolver.rb'


small_maze = [
[" "," ","█"," "," "],
[" "," "," "," ","█"],
[" ","█","█","█","█"],
[" "," "," "," "," "],
[" "," "," ","█"," "]
]

describe MazeSolver do
  context "#new" do
    it "instantiates a new maze without errors" do   
      new_maze = MazeSolver.new(small_maze)
      expect(new_maze.maze).to eq(small_maze)
    end
  end
    
  context "#neighbours" do
	  it "should return all neighbours (coordinates above, below, left and right of input)" do
	   new_maze = MazeSolver.new(small_maze)	  
	   new_maze.neighbours([2,2]).sort.should == [[2,1],[1,2],[2,3],[3,2]].sort
     new_maze.neighbours([2,2]).count.should == 4
	  end

    it "should only return neighbours that are in the maze boundary" do
     new_maze = MazeSolver.new(small_maze)    
     new_maze.neighbours([0,2]).sort.should == [[1,2],[0,3],[0,1]].sort
     new_maze.neighbours([0,2]).count.should == 3

     new_maze.neighbours([4,4]).sort.should == [[3,4],[4,3]].sort
     new_maze.neighbours([4,4]).count.should == 2
    end
  end

  context "#blocked?" do
    it "returns true if coordinate contains a '█' else false" do
      new_maze = MazeSolver.new(small_maze)
      new_maze.blocked?([1,1]).should eq(false)
      new_maze.blocked?([2,2]).should eq(true)
    end
  end


end 
