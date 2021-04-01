module MyTools
  class PlaceDataScraper
    attr_reader :url

    def initialize(url)
      @url = url
      @scrape_process = MyTools::SeleniumTool.new(@url)
    end

    #save_reviewがplace_idを受け取れるようにする
    def save_review(place_id)
      results = @scrape_process.fetch_reviews

      results.each do |result|
        Review.create(
          text: result[:text],
          count: result[:count],
          star: result[:star],
          place_id: place_id,
        )
      end
    end

    def save_place
      result = @scrape_process.fetch_place
      Place.create(place_name: result[:place_name], address: result[:address])
    end
  end
end
