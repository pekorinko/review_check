module MyTools
  class Result
    attr_reader :place_name,
                :address,
                :star_ave,
                :count_ave,
                :text_ave,
                :credibility_rate

    def initialize(place, star_ave, count_ave, text_ave, credibility_rate)
      @place_name = place.place_name
      @address = place.address
      @star_ave = star_ave
      @count_ave = count_ave
      @text_ave = text_ave
      @credibility_rate = credibility_rate
    end
  end
end
