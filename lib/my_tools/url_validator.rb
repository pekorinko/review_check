module MyTools
  class UrlValidator
    def initialize(url)
      @url = url
    end

    def validate
      #urlがあっているのか確認する
      uri = URI.parse(@url)
      if uri.host == 'www.google.com'
        true
      else
        false
        # 正しいURLか判別、"www.google.com"→GOOGLEならtrue、違うならfalseの処理を書く
      end
    end
  end
end
