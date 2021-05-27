module MyTools
  class UrlValidator
    def initialize(url)
      @url = url
    end

    def validate
      @url.include?('www.google.com') ? true : false
    end
  end
end
