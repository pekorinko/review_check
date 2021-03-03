module MyTools
    class PlaceDataScraper
        def initialize(text,count,star)
            @text = text
            @count = count
            @star = star
        end
        
        def scrape
            # Seleniumの処理
            # MyTools::SeleniumTool.access_url
            scrape_process = MyTools::SeleniumTool.new('text','count','star')
            scrape_process.access_url
        end    

        def dog
            p 'nyan'
        end
    end
end