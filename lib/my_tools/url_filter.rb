module MyTools
  class UrlFilter
    def initialize(url)
      @url = url
    end

    def filter
      if @url.include?(';tbs:lrf:') && @url.include?('mv:[[')
        @url.split('mv:[[')[0]
      elsif @url.include?(';tbs:lrf:')
        @url.split(';tbs:lrf:')[0]
      elsif @url.include?('mv:[[')
        @url.split('mv:[[')[0]
      elsif @url.exclude?(';tbs:lrf:') || @url.exclude?('mv:[[')
        return @url
      end
    end
  end
end
