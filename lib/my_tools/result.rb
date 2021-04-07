module MyTools
  class Result
    attr_reader :place_name,
                :address,
                :star_ave,
                :count_ave,
                :text_ave,
                :credibility_rate,
                :credible_star_ave

    def initialize(
      place,
      star_ave,
      count_ave,
      text_ave,
      credibility_rate,
      credible_star_ave
    )
      @place_name = place.place_name
      @address = place.address
      @star_ave = star_ave
      @count_ave = count_ave
      @text_ave = text_ave
      @credibility_rate = credibility_rate
      @credible_star_ave = credible_star_ave
    end
  end
end
