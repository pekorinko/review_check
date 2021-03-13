class ResultsController < ApplicationController
  def create
    url = params[:url]
    @place = MyTools::PlaceDataScraper.new(url).scrape
  end

  def show; end

  def result_params
    params.require(:result).permit(:url)
  end
end
