require 'nokogiri'
require 'open-uri'
require 'pry'
require 'pp'

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

# def sanitize_links(links)
#   cleaner_links = links.collect do |link|
#     get_wikis_only(link) if !link.nil?
#   end
# end
def crawl(links)
  count = 0
  #while count < 100
    #binding.pry
    current_link = links[count]
    begin
      doc = Nokogiri::HTML(open(full_url(current_link)))
    rescue
      #next
    end
    #p "#{count}: #{current_link}"

    puts "grabbing from #{current_link}".center(80, "===")
    get_wikis_only(find_links(doc)).each{|x| links << x}

    count += 1
 # end
end
 crawl(links)
 puts "-------------========----------These are the links! -------------========----------"
 pp links