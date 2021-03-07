module MyTools
    class PlaceDataScraper

        attr_reader :url
        def initialize(url)
            @url = url
        end

        def scrape
            # Seleniumの処理
            scrape_process = MyTools::SeleniumTool.new(@url)
            scrape_process.access_url
        end    

    end
end