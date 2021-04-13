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
      # @url.split(';tbs:lrf:')[0] if @url.include?(';tbs:lrf:')
      # @url.split('mv:[[')[0] if @url.include?('mv:[[')
      # return @url if @url.exclude?(';tbs:lrf:') || @url.exclude?('mv:[[')
    end
  end
end