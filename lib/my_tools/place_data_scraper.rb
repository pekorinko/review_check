module MyTools
  class PlaceDataScraper
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def review_save
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

    def place_save
      scrape_process = MyTools::SeleniumTool.new(@url)
      results = scrape_process.place_info
      Place.create!(place_name: 'カオマンガイバザール', address: '東京都三鷹市')
      # Place.create!(place_name: results[:place_name], results[:address])
    end
  end
end
