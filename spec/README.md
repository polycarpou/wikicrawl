This is a Breadth First Search algorithm which is used to solve a maze.

To begin writing your own mazesolver, first create the methods listed in the spec. The bfs method puts it all together. The pseudocode for the bfs is as follows:


bfs(start, looking_for)
  create arrays
  add the start to the arrays
  while the queue is not empty
    take out the first element in the queue
    for each of the neighbours of this first element 
      if its not in the visited set and not blocked
        add this to the arrays
        if this contains what we are looking for
          return the backtrack of this node
        end if
      end if
    end for
  end while
end method

The following video explains the BFS algorithm: http://www.youtube.com/watch?v=QRq6p9s8NVg
