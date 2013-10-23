require 'nokogiri'
require 'open-uri'
require 'pry'
require 'pp'
require 'ap'

links = ["/wiki/Flatiron_District"]
def get_wikis_only(links_array)
  links_array.keep_if{|l| l=~ /^\/wiki\/[^"]+/}
end

def find_links(doc)
  doc.css('a').collect { |link| link.attr('href') }
end

def full_url(wiki_id)
  "http://www.wikipedia.org#{wiki_id}"
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

def neighbours(current)
  begin
    doc = Nokogiri::HTML(open(full_url(current)))
  rescue
  end
  puts "grabbing from #{current}".center(80, "===")
  get_wikis_only(find_links(doc))
end

def bfs(start, looking_for)
  queueQ = []
  setV = []

  queueQ.push(start)
  setV << start
  path = []
  path << [start,"start"]
  while !queueQ.empty? || setV.length < 1000
    t = queueQ.shift
    # if t is what we are looking for then
    # if t == looking_for
    #    puts "found what im looking for!"
    #    binding.pry
    #    #back_path =  backtrack(path, t)
    #    #maze_path(g,back_path)
    #    return t
    # end
    p t
     # for all edges e in G.adjacentEdges(t) loop
    u = neighbours(t)
    u.each do |node|
      if !setV.include?(node)
        setV << node
        queueQ << node
        path << [node, t]
        if node == looking_for
          puts "found what im looking for!"
          binding.pry
          #back_path =  backtrack(path, t)
          #maze_path(g,back_path)

          return backtrack(path, node).unshift(looking_for)[0..-2]
        end
      end
    end
  end
end

#ap neighbours("/wiki/Flatiron_District")
p bfs("/wiki/Charging_Bull", "/wiki/Nicosia")