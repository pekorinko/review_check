module MyTools
  class UrlValidator
    def initialize(url)
      @url = url
    end

    def validate
      # URI.parse(@url)時に変な要素が含まれていることがBadURLエラーの原因だった
      # そのため、URI.parse(@url)しないでGoogleのURLか否か判断するコードに書き換えた
      # uri = URI.parse(@url)
      # uri.host == 'www.google.com' ? true : false
      if @url.include?('www.google.com')
        return @url
      else
        false
      end
    end
  end
end
