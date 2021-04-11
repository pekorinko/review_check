class ResultsController < ApplicationController
  def index
    redirect_to new_result_path
  end

  def new; end

  def create
    url = params[:url]

    url_filter = MyTools::UrlFilter.new(url)
    url = url_filter.filter

    # GoogleのURLで変な要素付きのURLでもurl_validatorでURI.parseしちゃうからお腹壊す
    # もしhostがgoogleだったらurl_validatorをそもそも起動させないようにする
    url_validator = MyTools::UrlValidator.new(url)

    if url_validator.validate
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
