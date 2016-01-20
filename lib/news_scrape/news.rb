
class NewsScrape::News

  attr_accessor :title, :summary, :author, :url

  @@stories = []

  def initialize(title=nil, author=nil)
    @title = title
    @author = author
  end

  def self.scrape_today 
    doc = Nokogiri::HTML(open("http://www.nytimes.com"))
    doc.search("div .span-ab-layout div .collection").each do |story|
      self.new_from_doc(story)
    end
  end
  
  def self.all
    @@stories
  end
  
  def self.new_from_doc(story)
    self.new.tap do |s|
      s.title = story.search("h2.story-heading").text.strip
      s.author = story.search("p.byline").text.strip
      s.summary = story.search("p.summary").text.strip
      
      # Defensive Programming
      if article_a_tag = story.search("a").first
        s.url = article_a_tag.attribute("href").value
      end
      
      s.save if s.valid?
    end 
  end

  def save
    @@stories << self
  end

  def valid?
    !(self.title.empty? && self.author.empty?) && !self.class.find_by_title(self.title)
  end

  def self.find_by_title(title)
    @@stories.detect{|o| title == o.title} 
  end
end