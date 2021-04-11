module MyTools
  class UrlValidator
    def initialize(url)
      @url = url
    end

    def validate
      unless @url.include?(';tbs:lrf:') || @url.include?('mv:[[')
        uri = URI.parse(@url)
        uri.host == 'www.google.com' ? true : false
      end
    end
  end
end
