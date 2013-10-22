require 'nokogiri'
require 'open-uri'
require 'sqlite3'
require 'pry'
class Crawl
  @@all_links = []
  def initialize(url)
    @url = url
  end
  def scrape
    @index = Nokogiri::HTML(open(@url))
    links = @index.css('a').map do |x|
      x.attr("href")
    end
    #
    # clean_links = links.each do |i|
    #   @@all_links << i if i.match(/http:\/\//)
    # end
    #links.select! { |v| v = /^([a-zA-Z0-9\-\.]+\.com)$/ }
    links = links.map do |each_link|
      begin 
        #each_link.match /https?:\/\/www\.([\da-zA-Z\.-]+)/
        each_link.match /\/wiki\/.+/ 
      rescue
      end
       #{|v| v = /https?:\/\/www\.([\da-zA-Z\.-]+)/}
    end
    pp links.compact
  end
end

c = Crawl.new("http://en.wikipedia.org/wiki/Flatiron_District")
c.scrape