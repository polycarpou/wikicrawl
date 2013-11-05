
maze = [["█","█","█","█"," "," ","█","█","█"," "," "," ","█","█"," "," "," "," ","█"," ","█","█","█","█"," "," ","█","█","█"," "," "," "," "," "," ","█","█"," ","█","█"],
        ["█","█","█","█"," "," ","█","█"," "," ","█"," "," "," "," "," ","█"," "," "," ","█","█","█","█"," "," ","█"," "," "," "," "," ","█","█"," "," ","█","█","█"," "],
        ["█"," "," "," "," "," ","█"," "," ","█","█","█","█","█"," "," ","█","█","█"," ","█","█","█","█"," "," ","█"," ","█"," ","█","█","█","█"," "," "," "," "," "," "],
        ["█"," ","█","█"," "," "," "," ","█","█","█","█","█","█"," "," ","█","█","█"," ","█","█","█","█"," "," ","█"," ","█"," ","█"," ","█","█"," "," ","♥"," ","█"," "],
        ["█"," ","█","█"," ","█","█"," "," "," ","█"," "," ","█"," "," ","█","█","█"," ","█","█","█","█"," "," "," "," ","█","█","█"," ","█","█"," "," "," "," ","█","█"],
        ["█"," ","█","█"," ","█","█","█","█"," "," "," "," "," "," "," ","█","█","█"," ","█"," "," "," "," "," ","█"," ","█"," "," "," ","█","█"," "," ","█","█","█","█"],
        ["█"," ","█","█"," "," ","█","█","█","█","█","█","█","█"," "," ","█"," "," "," ","█"," ","█","█"," "," ","█"," ","█"," "," "," ","█","█","█","█","█"," ","█"," "],
        ["█"," "," ","█","█"," "," "," ","█","█","█","█","█","█"," "," "," "," ","█"," "," "," ","█","█"," "," ","█","█","█"," "," "," ","█","█"," "," "," "," ","█","█"],
        ["█","█"," ","█","█","█","█"," "," "," ","█","█","█","█","█"," ","█","█","█","█","█","█","█","█"," "," ","█","█","█"," "," "," ","█"," "," "," "," ","█","█"," "],
        ["→"," "," ","█"," "," ","█","█","█","█","█","█","█","█","█","█","█","█","█"," ","█","█","█","█"," "," ","█"," "," "," "," "," "," "," "," "," "," "," "," "," "],
        ["█","█","█","█"," "," ","█","█","█"," "," "," ","█","█"," "," "," "," ","█"," ","█","█","█","█"," "," ","█","█","█"," "," "," "," "," "," ","█","█"," ","█","█"],
        ["█","█","█","█"," "," ","█","█"," "," ","█"," "," "," "," "," ","█"," "," "," ","█","█","█","█"," "," ","█"," "," "," "," "," ","█","█"," "," ","█","█","█"," "],
        ["█"," "," "," "," "," ","█"," "," ","█","█","█","█","█"," "," ","█","█","█"," ","█","█","█","█"," "," ","█"," ","█"," ","█","█","█","█"," "," "," "," "," "," "],
        ["█"," ","█","█"," "," "," "," ","█","█","█","█","█","█"," "," ","█","█","█"," ","█","█","█","█"," "," ","█"," ","█"," ","█","♥"," ","█"," "," "," "," ","█"," "],
        ["█"," ","█","█"," ","█","█"," "," "," ","█"," "," ","█"," "," ","█","█","█"," ","█","█","█","█"," "," "," "," ","█","█","█"," ","█","█"," "," "," "," ","█"," "],
        ["█"," ","█","█"," ","█","█","█","█"," "," "," "," "," "," "," ","█","█","█"," ","█"," "," "," "," "," ","█"," ","█"," "," "," ","█","█"," "," ","█","█","█"," "],
        ["█"," ","█","█"," "," ","█","█","█","█","█","█","█","█"," "," ","█"," "," "," ","█"," ","█","█"," "," ","█"," ","█"," "," "," ","█","█","█","█","█"," ","█"," "],
        ["█"," "," ","█","█"," "," "," ","█","█","█","█","█","█"," "," "," "," ","█"," "," "," ","█","█"," "," ","█","█","█"," "," "," ","█","█"," "," "," "," ","█"," "],
        ["█","█"," ","█","█","█","█"," "," "," ","█","█","█","█","█"," ","█","█","█","█","█","█","█","█"," "," ","█","█","█"," "," "," ","█"," "," "," "," ","█","█"," "],
        [" "," "," ","█"," "," ","█","█","█","█","█","█","█","█","█","█","█","█","█"," ","█","█","█","█"," "," ","█"," "," "," "," "," "," "," "," "," "," "," "," "," "]
      ]

class MazeSolver
  attr_accessor :maze, :path, :set, :queue
  
  def initialize(maze)
    @maze = maze
  end

  def for_print
    self.maze.each do |row|
      row.each do |box|
        print box
      end
      puts
    end
  end

  def maze_path(short_path)
    short_path.each do |point|
      unless point == "start"
        x = point[0]
        y = point[1]
        self.maze[x][y] = "o"
      end
    end
    for_print
  end

  def find_previous(point)
    path.each do |connect|
      return connect[1] if connect[0]==point
    end
  end

  def backtrack(end_point)
    point = end_point
    short = []
    until point == "start"
      point = find_previous(point)
      short << point
    end
    short
  end

  def blocked?(location)
    self.maze[location[1]][location[0]] == "█"? true : false
  end

  def neighbours(location)
    x,y = location[0],location[1]
    output = [[x-1,y],[x+1,y],[x,y+1],[x,y-1]]
    output.delete_if do |coordinates| 
      y,x = coordinates[0],coordinates[1]
      x <0 || y <0 || x > maze.length-1 || y >maze[0].length-1 
    end
  end

  def add_to_arrays(point, previous="start")
    queue << point
    set << point
    path << [point,previous]
  end

  def setup_arrays
    self.queue = []
    self.set = []
    self.path = []
  end

  def display_backtrack(back_path)
    maze_path(back_path)
  end

  def bfs(start, looking_for)
    setup_arrays
    add_to_arrays(start)
    while !queue.empty?
      t = queue.shift
      neighbours(t).each do |node|
        if !set.include?(node) and !blocked?(node)
          add_to_arrays(node, t)
          if maze[node[1]][node[0]] == looking_for
      #      puts "Found what I was looking for!"
      #      display_backtrack(backtrack(node))
            return backtrack(node).reverse.reject{|x| x== 'start'}
          end
        end
      end
    end
    #puts "I've got 99 problems but a ♥ aint one."
  end
end

# new_maze = MazeSolver.new(maze)
# system("clear")
# new_maze.for_print
# puts "Press Enter to Solve Maze!"
# gets
# system("clear")
# new_maze.bfs([9,0],"♥")
