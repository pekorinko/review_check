module MyTools
  class PlaceDataScraper
    attr_reader :url

    def initialize(url)
      @url = url
    end
<<<<<<< HEAD

    def scrape
      scrape_process = MyTools::SeleniumTool.new(@url)

      results = scrape_process.access_url

      # places = scrape_process.access_url

      results.each do |result|
        puts '*************************'
        puts result[:text]

        review =
          Review.create(
            text: result[:text],
            count: result[:count],
            star: result[:star],
          )
        puts review
      end
      Review.create(text: 'こんにちは', count: 4, star: 2.0)
      # places.each do |place|
      #   Place.create(
      #     place_name: place[:facility_name],
      #     address: place[:address],
      #   )
      # end
=======

    def scrape
      # Seleniumの処理
      scrape_process = MyTools::SeleniumTool.new(@url)
      results = scrape_process.access_url
      results.each do |result|
        Review.create(text: result[:text], count: result[:count], star: result[:star])
      end
      Review.find(1)
>>>>>>> 6e23f5216bd5a541ac1a577253f9d340480c43b4
    end
  end
end
