module MyTools
  class UrlFilter
    def initialize(url)
      @url = url
    end

    def filter
      @url.split(';tbs:lrf:')[0] if @url.include?(';tbs:lrf:')
      @url.split('mv:[[')[0] if @url.include?('mv:[[')
    end
  end
end
