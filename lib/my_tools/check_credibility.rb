module MyTools
  class CheckCredibility
    attr_reader :place_id

    def initialize(place_id)
      @place_id = place_id
    end

    def credibility
      reviews = Review.where(place_id: @place_id)
      stars = reviews.map { |review| review.star }
      total = 0
      stars.each { |star| total = total + star }
      return total / stars.length
    end
  end
end
