class NewsScrape::CLI

  def call
    
    list_news
    menu
    goodbye
  end

  def list_news
    puts "Today's news:"
    NewsScrape::News.scrape_today 
    NewsScrape::News.all.each.with_index(1) do |story, i|
      puts "#{i}. #{story.title} - #{story.author}"
    end
  end

  def menu
    input=nil
    while input !="exit"
      puts "enter the number of the news you like to read or type LIST to list the news or EXIT to exit. "
      input=gets.strip.downcase
      
      # make sure that we have an article for the the number they typed
      # use @stories.length to know how many articles
      if input.to_i > 0 # && input.to_i <= @stories.length
        the_story = NewsScrape::News.all[input.to_i-1]
        if the_story
          puts "#{the_story.title} - #{the_story.author}\n #{the_story.summary}\n\n#{the_story.url}"
          puts "Opening article..."
          sleep 1
          system("open #{the_story.url}")
        else
          puts "Can't find that story"
        end
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
