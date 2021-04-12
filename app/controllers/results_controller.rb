class ResultsController < ApplicationController
  attr_reader :url

  def index
    redirect_to new_result_path
  end

  def new; end

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
      place_data_scraper.save_review(place.id)
      check_credibility = MyTools::CheckCredibility.new(place.id)
      @result = check_credibility.credibility
    elsif url.exclude?('www.google.com') && !url_validator.validate
      flash.now[:alert] = 'URLが不正です'
      render :new
    end
  end

  # 上記のコードと下記、どちらが良いか迷っている↓
  # def create
  #   url = params[:url]
  #   url_filter = MyTools::UrlFilter.new(url)
  #   url_validator = MyTools::UrlValidator.new(url)

  #   if url.include?('www.google.com')
  #     url = url_filter.filter
  #     place_data_scraper = MyTools::PlaceDataScraper.new(url)
  #     place = place_data_scraper.save_place
  #     place_data_scraper.save_review(place.id)
  #     check_credibility = MyTools::CheckCredibility.new(place.id)
  #     @result = check_credibility.credibility
  #   end

  #   if url.exclude?('www.google.com') && url_validator.validate
  #     # GoogleのURLで変な要素付きのURLでもurl_validatorでURI.parseしちゃうからお腹壊す
  #     # もしhostがgoogleじゃなかった時だけ「url_validator.validate」を起動させたい
  #     place_data_scraper = MyTools::PlaceDataScraper.new(url)
  #     place = place_data_scraper.save_place
  #     place_data_scraper.save_review(place.id)
  #     check_credibility = MyTools::CheckCredibility.new(place.id)
  #     @result = check_credibility.credibility
  #   elsif url.exclude?('www.google.com') && !url_validator.validate
  #     flash.now[:alert] = 'URLが不正です'
  #     render :new
  #   end

  # end
end
