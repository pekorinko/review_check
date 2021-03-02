class Place < ApplicationRecord
    attr_reader :place_name, :address
    
    def initialize(place_name, address)
        @place_name = place_name
        @address = address
    end
end
