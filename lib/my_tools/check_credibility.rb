module MyTools
  class CheckCredibility
    def initialize(place_id)
      @place_id = place_id
    end

    def credibility
      reviews = Review.where(place_id: @place_id)
      texts = reviews.map { |review| review.text }
      stars = reviews.map { |review| review.star }
      counts = reviews.map { |review| review.count }

      total = 0
      count_total = 0
      text_total = 0

      texts.each { |text| text_total = text_total + text.size }
      stars.each { |star| total = total + star }
      counts.each { |count| count_total = count_total + count }

      @place = Place.find_by(id: @place_id)
      @star_ave = total / stars.length
      @count_ave = count_total / counts.length
      @text_ave = text_total / texts.length

      if @count_ave >= 20 and @text_ave >= 50
        @credibility_rate = '高'
      else
        @credibility_rate = '低'
      end

      return(
        Result.new(@place, @star_ave, @count_ave, @text_ave, @credibility_rate)
      )
    end
  end
end
