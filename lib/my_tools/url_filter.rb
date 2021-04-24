module MyTools
  class UrlFilter
    def initialize(url)
      @url = url
    end

    def filter
      tbs = ';tbs:lrf:'
      mv = 'mv:[['
      if @url.include?(tbs) && @url.include?(mv)
        @url.split(mv)[0]
      elsif @url.include?(tbs)
        @url.split(tbs)[0]
      elsif @url.include?(mv)
        @url.split(mv)[0]
      elsif @url.exclude?(tbs) || @url.exclude?(mv)
        return @url
      end
    end
  end
end
