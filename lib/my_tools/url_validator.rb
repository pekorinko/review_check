module MyTools
  class UrlValidator
    def initialize(url)
      @url = url
    end

    def validate
      if @url.include?('www.google.com')
        return @url
      else
        false
      end
    end
  end
end
