module MyTools
  class PlaceDataScraper
    attr_reader :url

    def initialize(url)
      #TODO: URLを二重管理しているのでなんとかする https://github.com/pekorinko/review_check/issues/71
      @scrape_process = MyTools::SeleniumTool.new(url)
      @url = @scrape_process.url
    end

    def save_review(place_id)
      results = @scrape_process.fetch_reviews
      reviews = Review.find_by(place_id: place_id)
      Review.where(place_id: place_id).delete_all if reviews.present?

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
      # 口コミが無いGoogleのURLが入力された際に発生するbugの確認をするため、以下のbinding.pryはコメントとして残す
      # binding.pry
      uri = URI.parse(@url)
      @lrd = uri.fragment.split('=')[1].split(',')[0]
      place = Place.find_by(lrd: @lrd)
      @result = @scrape_process.fetch_place

      if place.present?
        place.update(
          place_name: @result[:place_name],
          address: @result[:address],
          star_ave: @result[:star_ave],
        )
        return place
      end

      Place.create(
        url: @url,
        lrd: @lrd,
        place_name: @result[:place_name],
        address: @result[:address],
        star_ave: @result[:star_ave],
      )
    end
    def quit
      @scrape_process.quit
    end
  end
end
