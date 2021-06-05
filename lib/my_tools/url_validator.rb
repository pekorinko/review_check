module MyTools
  class UrlValidator
    def initialize(url)
      @url = url
    end

    def valid?
      @url.include?('www.google.com')
    end
  end
end
