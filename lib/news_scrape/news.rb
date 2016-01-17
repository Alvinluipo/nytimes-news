class NewsScrape::News

  attr_accessor :title, :article_url, :author

  @@stories = []

  def initialize(title=nil, author=nil)
    @title = title
    @author = author
  end

  def self.today 
    self.scrape_all
  end

  def self.scrape_all
    doc = Nokogiri::HTML(open("http://www.nytimes.com"))
    doc.search("div .span-ab-layout div .collection").each do |story|
      s = self.new
      s.title = doc.search("h2.story-heading").text
      s.author = doc.search("p.byline").text
      s.article_url = doc.search("h2.story-heading a").attr("href")
      @@stories << s
    end
  end

end