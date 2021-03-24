module MyTools
  class CheckCredibility
    attr_reader :place_id

    def initialize(place_id)
      @place = place_id
    end

    def credibility
      return '30%'
    end
  end
end
