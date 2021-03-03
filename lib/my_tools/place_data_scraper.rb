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
            p 'wan'
        end
    end
end
# p PlaceDataScraper::SeleniumTool
# MyTools::PlaceDataScraper.scrape

#PlaceDataScraperのインスタンスを作る
# scraper = MyTools::PlaceDataScraper.new('new')
# scraper.dog