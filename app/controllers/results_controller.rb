class ResultsController < ApplicationController
  def new
  end

  def create
    url = params[:url]
    @place = PlaceDataScraper.new(url).scrape
  end
end
