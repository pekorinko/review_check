module MyTools
  class SearchHistory
    attr_reader :result_id,
                :place_id,
                :place_name,
                :star_ave,
                :credible_star_ave
    def initialize(result_id, place_id, place_name, star_ave, credible_star_ave)
      @result_id = result_id
      @place_id = place_id
      @place_name = place_name
      @star_ave = star_ave
      @credible_star_ave = credible_star_ave
    end
  end
end
