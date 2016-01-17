class NewsScrape::CLI

  def call
    
    list_news
    menu
    goodbye
  end

  def list_news
    puts "Today's news:"
    @stories = NewsScrape::News.today 
    @stories.each.with_index(1) do |story, i|
      puts "#{i}. #{story.title} - #{story.author}"
    end
  end

  def menu
    input=nil
    while input !="exit"
      puts "enter the number of the news you like to read:"
      input=gets.strip.downcase
      
      if input.to_i > 0
        the_story= @stories[input.to_i-1]
        puts "#{i}. #{story.title} - #{story.author}"
      elsif input=="list"
        list_news
      else
        puts "Not sure what you want, type exit or list"
      end
    end  
  end

  def goodbye
    puts "See you later!!!"
  end
end
