module MyTools
  class PlaceDataScraper
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def scrape
      scrape_process = MyTools::SeleniumTool.new(@url)

      results = scrape_process.review_info

      results.each do |result|
        Review.create!(
          text: result[:text],
          count: result[:count],
          star: result[:star],
        )
      end
    end
  end
end
