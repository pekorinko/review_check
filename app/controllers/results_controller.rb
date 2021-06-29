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
    @url = localized_url(params[:url]) if url.include?('#')

    url_filter = MyTools::UrlFilter.new(@url)
    @url = url_filter.filter

    url_validator = MyTools::UrlValidator.new(@url)

    if url_validator.valid?
      begin
        @place_data_scraper = MyTools::PlaceDataScraper.new(@url)
        place = @place_data_scraper.save_place
        place_id = place.id
        @place_data_scraper.save_review(place_id)
        @place = @place_data_scraper.save_place
        @place_data_scraper.quit
        user_id = session[:user_id]
        check_credibility = MyTools::CredibilityChecker.new(place_id)
        @result = check_credibility.check(user_id)
        redirect_to result_path(@result)
      rescue StandardError => e
        logger.error(e.inspect)
        logger.error(e.backtrace.join("\n"))
        @place_data_scraper.quit
        redirect_to root_path, alert: '口コミの取得に失敗しました'
      end
    else
      redirect_to root_path, alert: '不正なURLです'
    end
  end

  private

  # def localized_url(url)
  #   if url.include?('#')
  #     a, b = url.split('#')
  #     localized_query = '&gl=jp&hl=ja&gws_rd=cr&pws=0'
  #     return a + @localized_query + '#' + b
  #   else
  #     localized_query = '&gl=jp&hl=ja&gws_rd=cr&pws=0'
  #     return url.to_s + localized_query
  #   end
  # end
  def localized_url(url)
    if url.include?('#')
      a, b = url.split('#')
      localized_query = '&gl=jp&hl=ja&gws_rd=cr&pws=0'
      a + localized_query + '#' + b
    else
      redirect_to root_path, alert: '口コミの取得に失敗しました'
    end
  end
end
