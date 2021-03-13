module MyTools
  class PlaceDataScraper
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def scrape
      # Seleniumの処理
      scrape_process = MyTools::SeleniumTool.new(@url)
      results = scrape_process.access_url
      results.each do |result|
        Review.create(text: result[:text], count: result[:count], star: result[:star])
      end
      Review.find(1)
    end
  end
end
