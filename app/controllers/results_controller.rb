class ResultsController < ApplicationController
  skip_before_action :authenticate, except: :index

  def index
    search_histories =
      current_user
        .results
        .select('DISTINCT ON (place_id) *')
        .order(place_id: :desc)
        .limit(6)
    @search_histories =
      search_histories.map do |search_history|
        place = Place.find(search_history.place_id)
        MyTools::SearchHistory.new(
          search_history.id,
          place.id,
          place.place_name,
          place.star_ave,
          search_history.credible_star_ave,
        )
      end
  end

  def new
    @result_histories =
      Result.select('DISTINCT ON (place_id) *').order(place_id: :desc).limit(3)
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
      begin
        # binding.pry
        place_data_scraper = MyTools::PlaceDataScraper.new(@url)
        place = place_data_scraper.save_place
        place_id = place.id
        place_data_scraper.save_review(place_id)
        @place = place_data_scraper.save_place
        user_id = session[:user_id]
        check_credibility = MyTools::CheckCredibility.new(place_id)
        @result = check_credibility.credibility(user_id)
        redirect_to result_path(@result)
      rescue StandardError
        redirect_to root_path, alert: '口コミの取得に失敗しました'
      end
    else
      redirect_to root_path, alert: '不正なURLです'
    end
  end
end
