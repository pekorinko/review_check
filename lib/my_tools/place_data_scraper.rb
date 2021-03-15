module MyTools
  class PlaceDataScraper
    attr_reader :url

    def initialize(url)
      @url = url
      @scrape_process = MyTools::SeleniumTool.new(@url)
    end

    def save_review
      results = @scrape_process.fetch_reviews

      results.each do |result|
        Review.create!(
          text: result[:text],
          count: result[:count],
          star: result[:star],
        )
      end
    end

    def save_place
      result = @scrape_process.fetch_place

      # binding.pry
      # Place.create!(place_name: 'カオマンガイバザール', address: '東京都三鷹市')
      Place.create!(place_name: result[:place_name], address: result[:address])
    end
  end
end
