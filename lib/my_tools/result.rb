module MyTools
  class Result
    attr_reader :place_name, :address, :star_ave, :count_ave, :text_ave

    def initialize(place, star_ave, count_ave, text_ave)
      @place_name = place.place_name
      @address = place.address
      @star_ave = star_ave
      @count_ave = count_ave
      @text_ave = text_ave
    end
  end
end
