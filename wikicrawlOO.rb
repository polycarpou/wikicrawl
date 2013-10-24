require 'nokogiri'
require 'open-uri'

class WikiCrawl
  attr_accessor :maze, :path, :set, :queue

  def get_wikis_only(links_array)
    links_array.keep_if{|l| l=~ /^\/wiki\/[^"]+/}
  end

  def find_links(doc)
    doc.css('a').collect { |link| link.attr('href') }
  end

  def full_url(wiki_id)
    "http://www.wikipedia.org#{wiki_id}"
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

  def neighbours(current)
    begin
      doc = Nokogiri::HTML(open(full_url(current)))
      puts "grabbing from #{current}".center(80, "===")
      get_wikis_only(find_links(doc))
    rescue
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

  def display_backtrack(back_path, looking_for)
    puts back_path.unshift(looking_for)[0..-2]
  end

  def bfs(start, looking_for)
    setup_arrays
    add_to_arrays(start)
    while !queue.empty?
      t = queue.shift
      neighbours(t).each do |node|
        if !set.include?(node)
          add_to_arrays(node, t)
          if node == looking_for
            puts "Found what I was looking for!"
            display_backtrack(backtrack(node), looking_for)
            return node
          end
        end
      end
    end
  end
end
new_crawl = WikiCrawl.new
#new_crawl.bfs("/wiki/Charging_Bull", "/wiki/Cyprus")
new_crawl.bfs("/wiki/Charging_Bull", "/wiki/Polar_bear")

puts "I processed #{new_crawl.set.count} wikipedia links to find this path."