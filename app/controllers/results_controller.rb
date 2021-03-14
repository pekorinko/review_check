class ResultsController < ApplicationController
  def create
    url = params[:url]
    place_data_scraper = MyTools::PlaceDataScraper.new(url)
    @place = place_data_scraper.review_save
    place_data_scraper.place_save
  end

  def show; end

  def result_params
    params.require(:result).permit(:url)
  end
end
