class NewsScrape::News

  attr_accessor :title, :article_url, :author


  def initialize(title=nil, author=nil)
    @title=title
    @author=author
  end

  def self.today 
    self.scrape
  end

  def self.scrape
    stories=[]

    stories<< self.scrape_all

    stories
  end 

  def self.scrape_all
    doc = Nokogiri::HTML(open("http://www.nytimes.com"))
    story=self.new
    story.title = doc.search("h2.story-heading")[1].text
    story.author = doc.search("p.byline")[1].text
    story.article_url = doc.search("h2.story-heading a").attr("href")
    story
  

 
  end
end