module MyTools
  class PlaceDataScraper
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def scrape
      scrape_process = MyTools::SeleniumTool.new(@url)

      results = scrape_process.access_url

      # places = scrape_process.access_url

      results.each do |result|
        puts '*************************'
        puts result[:text]

        review =
          Review.create!(
            text: result[:text],
            count: result[:count],
            star: result[:star],
          )
        puts review
      end

      # places.each do |place|
      #   Place.create(
      #     place_name: place[:facility_name],
      #     address: place[:address],
      #   )
      # end
    end
  end
end
