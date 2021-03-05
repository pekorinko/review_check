class Review < ApplicationRecord
    attr_reader :text, :count, :star

    def initialize(text, count, star)
        @text = text
        @count = count
        @star = star
    end

    
end
