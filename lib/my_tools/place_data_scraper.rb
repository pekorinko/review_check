module MyTools
    class PlaceDataScraper
        def initialize(url)
            @url = url
        end
        
        def scrape
            # Seleniumの処理
            # MyTools::SeleniumTool.access_url
            scrape_process = MyTools::SeleniumTool.new
            scrape_process.access_url
        end    

        def dog
            p 'nyan'
        end
    end
end