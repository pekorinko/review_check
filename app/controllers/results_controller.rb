class ResultsController < ApplicationController
  attr_reader :url

  def index
    redirect_to new_result_path
  end

  def new; end

  def show
    # DBから引っ張ってくるための処理
    @result = Result.find(params[:id])
  end

  def create
    @url = params[:url]

    if @url.include?('www.google.com')
      url_filter = MyTools::UrlFilter.new(@url)
      @url = url_filter.filter
    end

    url_validator = MyTools::UrlValidator.new(@url)
    if url_validator.validate
      @url = url_validator.validate
      place_data_scraper = MyTools::PlaceDataScraper.new(@url)
      place = place_data_scraper.save_place
      @place_id = place.id
      place_data_scraper.save_review(@place_id)
      @place = place_data_scraper.save_place
      check_credibility = MyTools::CheckCredibility.new(@place_id)
      @result = check_credibility.credibility

      # resultコントローラのshowに飛ぶ /results/:id にリダイレクトされる このコードはこういうものだから
      # redirect_to @resultでも同じ働きをする
      # 以下を書くと結果画面が表示されずに入力画面に行ってしまう
      # redirect_to results_path(@result)
    elsif url.exclude?('www.google.com') && !url_validator.validate
      flash.now[:alert] = 'URLが不正です'
      render :new
    end
    # redirect_to results_path(@result)
  end
end
