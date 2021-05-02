class ResultsController < ApplicationController
  attr_reader :url

  def index
    redirect_to new_result_path
  end

  def new
    result_histories =
      Result.select('DISTINCT ON (place_id) *').order(place_id: :desc).limit(5)
    @histories =
      result_histories.map do |result_history|
        place = Place.find(result_history.place_id)
        history =
          MyTools::History.new(
            result_history.id,
            place.id,
            place.place_name,
            result_history.star_ave,
            result_history.credible_star_ave,
          )
      end
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
      @place_id = place.id
      place_data_scraper.save_review(@place_id)
      @place = place_data_scraper.save_place
      check_credibility = MyTools::CheckCredibility.new(@place_id)
      @result = check_credibility.credibility
      redirect_to result_path(@result)
    elsif url.exclude?('www.google.com') && !url_validator.validate
      redirect_to root_path, notice: '不正なURLです'
    end
  end
end
