require 'nokogiri'
require 'open-uri'
#require 'rest-open-uri'
require 'pry'
require 'pp'
require 'ap'

links = ["/wiki/Flatiron_District"]
def get_wikis_only(links_array)
  links_array.keep_if{|l| l=~ /http:\/\/127.0.0.1:3000\/wikipedia_en_wp1_0.5_2000plus_03_2007_rc2.+/}
end

def find_links(doc)
  doc.css('a').collect { |link| link.attr('href') }
end

def full_url(wiki_id)
  "http://192.168.2.105:8000#{wiki_id}"
end

#ap full_url("/wikipedia_en_wp1_0.5_2000plus_03_2007_rc2/A/China.html")
#ap Nokogiri::HTML(open("http://127.0.0.1/:3000/wikipedia_en_wp1_0.5_2000plus_03_2007_rc2/A/China.html"))
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
  count = 0
  path = []
  path << [start,"start"]
     # while Q is not empty loop
  while !queueQ.empty? || setV.length < 1000
    t = queueQ.shift
    # if t is what we are looking for then
    if t == looking_for
       puts "found what im looking for!"
       binding.pry
       #back_path =  backtrack(path, t)
       #maze_path(g,back_path)
       return t
    end
    p t
     # for all edges e in G.adjacentEdges(t) loop
    u = neighbours(t)
    u.each do |node|
      if !setV.include?(node)
        setV << node
        queueQ << node
        path << [node, t]
      end
    end
  end
end
doc = Nokogiri::HTML(open("http://127.0.0.1:8000/wikipedia_en_wp1_0.5_2000plus_03_2007_rc2/A/Novel.html"))
#doc = Nokogiri::HTML(open("http://www.imdb.com"))
p doc
#ap neighbours("/wikipedia_en_wp1_0.5_2000plus_03_2007_rc2/A/China.html")
#bfs("/wikipedia_en_wp1_0.5_2000plus_03_2007_rc2/A/China.html", "/wikipedia_en_wp1_0.5_2000plus_03_2007_rc2/A/Vincent_van_Gogh.html")