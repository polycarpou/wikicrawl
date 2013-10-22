# def bfs(g,v)
require 'pp'
require 'ap'
# def effect(str, *attributes)
#   on = "\e[#{attributes.join(";")}m"
#   off = "\e[0m"
#   "#{on}#{str}#{off}"
# end
# end
maze = [["█","█","█","█"," "," ","█","█","█"," "," "," ","█","█"," "," "," "," ","█"," ","█","█","█","█"," "," ","█","█","█"," "," "," "," "," "," ","█","█"," ","█"," "],
        ["█","█","█","█"," "," ","█","█"," "," ","█"," "," "," "," "," ","█"," "," "," ","█","█","█","█"," "," ","█"," "," "," "," "," ","█","█"," "," ","█","█","█"," "],
        ["█"," "," "," "," "," ","█"," "," ","█","█","█","█","█"," "," ","█","█","█"," ","█","█","█","█"," "," ","█"," ","█"," ","█","█","█","█"," "," "," "," "," "," "],
        ["█"," ","█","█"," "," "," "," ","█","█","█","█","█","█"," "," ","█","█","█"," ","█","█","█","█"," "," ","█"," ","█"," ","█"," ","█","█"," ","*"," "," ","█"," "],
        ["█"," ","█","█"," ","█","█"," "," "," ","█"," "," ","█"," "," ","█","█","█"," ","█","█","█","█"," "," "," "," ","█","█","█"," ","█","█"," "," "," "," ","█"," "],
        ["█"," ","█","█"," ","█","█","█","█"," "," "," "," "," "," "," ","█","█","█"," ","█"," "," "," "," "," ","█"," ","█"," "," "," ","█","█"," "," ","█","█","█"," "],
        ["█"," ","█","█"," "," ","█","█","█","█","█","█","█","█"," "," ","█"," "," "," ","█"," ","█","█"," "," ","█"," ","█"," "," "," ","█","█","█","█","█"," ","█"," "],
        ["█"," "," ","█","█"," "," "," ","█","█","█","█","█","█"," "," "," "," ","█"," "," "," ","█","█"," "," ","█","█","█"," "," "," ","█","█"," "," "," "," ","█"," "],
        ["█","█"," ","█","█","█","█"," "," "," ","█","█","█","█","█"," ","█","█","█","█","█","█","█","█"," "," ","█","█","█"," "," "," ","█"," "," "," "," ","█","█"," "],
        [" "," "," ","█"," "," ","█","█","█","█","█","█","█","█","█","█","█","█","█"," ","█","█","█","█"," "," ","█"," "," "," "," "," "," "," "," "," "," "," "," "," "],
        ["█","█","█","█"," "," ","█","█","█"," "," "," ","█","█"," "," "," "," ","█"," ","█","█","█","█"," "," ","█","█","█"," "," "," "," "," "," ","█","█"," ","█"," "],
        ["█","█","█","█"," "," ","█","█"," "," ","█"," "," "," "," "," ","█"," "," "," ","█","█","█","█"," "," ","█"," "," "," "," "," ","█","█"," "," ","█","█","█"," "],
        ["█"," "," "," "," "," ","█"," "," ","█","█","█","█","█"," "," ","█","█","█"," ","█","█","█","█"," "," ","█"," ","█"," ","█","█","█","█"," "," "," "," "," "," "],
        ["█"," ","█","█"," "," "," "," ","█","█","█","█","█","█"," "," ","█","█","█"," ","█","█","█","█"," "," ","█"," ","█"," ","█","*","█","█"," "," "," "," ","█"," "],
        ["█"," ","█","█"," ","█","█"," "," "," ","█"," "," ","█"," "," ","█","█","█"," ","█","█","█","█"," "," "," "," ","█","█","█"," ","█","█"," "," "," "," ","█"," "],
        ["█"," ","█","█"," ","█","█","█","█"," "," "," "," "," "," "," ","█","█","█"," ","█"," "," "," "," "," ","█"," ","█"," "," "," ","█","█"," "," ","█","█","█"," "],
        ["█"," ","█","█"," "," ","█","█","█","█","█","█","█","█"," "," ","█"," "," "," ","█"," ","█","█"," "," ","█"," ","█"," "," "," ","█","█","█","█","█"," ","█"," "],
        ["█"," "," ","█","█"," "," "," ","█","█","█","█","█","█"," "," "," "," ","█"," "," "," ","█","█"," "," ","█","█","█"," "," "," ","█","█"," "," "," "," ","█"," "],
        ["█","█"," ","█","█","█","█"," "," "," ","█","█","█","█","█"," ","█","█","█","█","█","█","█","█"," "," ","█","█","█"," "," "," ","█"," "," "," "," ","█","█"," "],
        [" "," "," ","█"," "," ","█","█","█","█","█","█","█","█","█","█","█","█","█"," ","█","█","█","█"," "," ","█"," "," "," "," "," "," "," "," "," "," "," "," "," "]

      ]

# puts effect("X",[1,6])
def for_print(grid)
  grid.each do |row|
    row.each do |box|
      print box
    end
    puts
  end
end
def mazemod(maze, distance)
  distance.each do |points|
    x = points[0][0]
    y = points[0][1]
    maze[x][y] = points[1]
  end 
  for_print(maze)
end

def maze_path(maze, short_path)
  short_path.each do |point|
    unless point == "start"
      x = point[0]
      y = point[1]
      maze[x][y] = "o"
    end
  end
  for_print(maze)
end
def find_previous(path, point)
  path.each do |connect|
    return connect[1] if connect[0]==point
  end
end


def backtrack(path, end_point)
  point = end_point
  short = []
  until point == "start"
    point = find_previous(path, point)
    short << point
  end
  short
  
end
system("clear")
for_print(maze)
sleep 5

def blocked?(location,maze)
  maze[location[0]][location[1]] == "█"? true : false
end

def neighbours(location, maze)
  x = location[0]
  y = location[1]
  output = []
  output << [x-1,y]
  output << [x+1,y]
  output << [x,y+1]
  output << [x,y-1]
  output.delete_if do |coordinates| 
    x = coordinates[0]
    y = coordinates[1]
    x <0 || y <0 || x > maze.length-1 || y >maze[0].length-1 
  end
end


  def bfs (g,v,looking_for)
 # procedure BFS(G,v) is
     queueQ = []
     setV = []

     queueQ.push(v)
     setV << v
     count = 0
     path = []
     path << [v,"start"]
     
     # while Q is not empty loop
     while !queueQ.empty?
        t = queueQ.shift
        # if t is what we are looking for then
        if g[t[0]][t[1]] == looking_for
           puts "found what im looking for!"
           back_path =  backtrack(path, t)
           maze_path(g,back_path)
           return t
        end
         # for all edges e in G.adjacentEdges(t) loop
        u = neighbours(t,g)
        u.each do |coordinates|
          if !setV.include?(coordinates) and !blocked?(coordinates, g)
            setV << coordinates
            queueQ << coordinates
            path << [coordinates, t]
          end
        end
    end

  end
system("clear")
bfs(maze, [9,0],"*")

 #oracleofbacon.org/movielinks.php?a=Christopher+Walken&b=Charles+Chaplin&use_using=1&u0=on&use_genres=1&g0=on&g4=on&g8=on&g16=on&g20=on&g1=on&g5=on&g9=on&g13=on&g17=on&g21=on&g25=on&g2=on&g6=on&g10=on&g14=on&g22=on&g26=on&g3=on&g11=on&g15=on&g23=on&g27=on


