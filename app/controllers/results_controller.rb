class ResultsController < ApplicationController
  skip_before_action :authenticate, except: :index

  def index
    search_histories =
      current_user
        .results
        .select('DISTINCT ON (place_id) *')
        .order(place_id: :desc)
        .limit(5)
    @search_histories =
      search_histories.map do |search_history|
        place = Place.find(search_history.place_id)
        MyTools::SearchHistory.new(
          search_history.id,
          place.id,
          place.place_name,
          search_history.star_ave,
          search_history.credible_star_ave,
        )
      end
  end

  def new
    @result_histories =
      Result.select('DISTINCT ON (place_id) *').order(place_id: :desc).limit(5)
  end

  def show
    @result = Result.find(params[:id])
    @place = Place.find(@result.place_id)
  end

  def create
    @url = params[:url]

    url_filter = MyTools::UrlFilter.new(@url)
    @url = url_filter.filter

    url_validator = MyTools::UrlValidator.new(@url)
    if url_validator.validate
      @url = url_validator.validate
      place_data_scraper = MyTools::PlaceDataScraper.new(@url)
      place = place_data_scraper.save_place
      place_id = place.id
      place_data_scraper.save_review(place_id)
      @place = place_data_scraper.save_place
      check_credibility = MyTools::CheckCredibility.new(place_id)
      @result = check_credibility.credibility(user_id)
      redirect_to result_path(@result)
    elsif @url.exclude?('www.google.com') && !url_validator.validate
      redirect_to root_path, notice: '不正なURLです'
    end
  end
end
