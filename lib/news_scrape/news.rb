
class NewsScrape::News

  attr_accessor :title, :summary, :author

  @@stories = []

  def initialize(title=nil, author=nil)
    @title = title
    @author = author
  end

  def self.today 
    self.scrape_all
    @@stories
  end

  def self.scrape_all
    doc = Nokogiri::HTML(open("http://www.nytimes.com"))
    doc.search("div .span-ab-layout div .collection").each do |story|
      s = self.new
      s.title = story.search("h2.story-heading").text.strip
      s.author = story.search("p.byline").text.strip
      s.summary = story.search("p.summary").text.strip
      
      @@stories << s

    end
  end

end