module MyTools
  class PlaceDataScraper
    attr_reader :url

    def initialize(url)
      @url = url
      @scrape_process = MyTools::SeleniumTool.new(@url)
    end

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
      uri = URI.parse(@url)
      lrd = uri.fragment.split('=')[1].split(',')[0]
      place = Place.find_by(lrd: lrd)
      if place.present?
        place
      else
        result = @scrape_process.fetch_place
        Place.create(
          lrd: lrd,
          place_name: result[:place_name],
          address: result[:address],
        )
      end
    end
  end
end
