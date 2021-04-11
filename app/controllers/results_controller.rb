class ResultsController < ApplicationController
  def index
    redirect_to new_result_path
  end

  def new; end

  def create
    url = params[:url]

    #加工すればなんとかなるURL→加工用ファイルをmy_toolsに作ってコントローラーで呼び出すようにする url_filter.rb→フィルタリングした結果のURLを文字列で返すようにする
    url = url.split(';tbs:lrf:')[0] if url.include?(';tbs:lrf:')
    url = url.split('mv:[[')[0] if url.include?('mv:[[')

    # url_filter = MyTools::UrlFilter.new
    # url = url_filter.filter

    #そもそも駄目なURLを弾く仕組み→駄目なURLが来たらセレニウムを立ち上げる前に弾きたい
    url_validator = MyTools::UrlValidator.new(url)
    if url_validator.validate
      # もともとあった処理（PlaceDataScraper呼んだりとか）
      place_data_scraper = MyTools::PlaceDataScraper.new(url)
      place = place_data_scraper.save_place
      place_data_scraper.save_review(place.id)
      check_credibility = MyTools::CheckCredibility.new(place.id)
      @result = check_credibility.credibility
    else
      flash.now[:alert] = 'URLが不正です'
      render :new
    end
  end
end
