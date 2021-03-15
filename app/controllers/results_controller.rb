class ResultsController < ApplicationController
  def new; end

  def create
    url = params[:url]
    place_data_scraper = MyTools::PlaceDataScraper.new(url)
    place_data_scraper.review_save
    place_data_scraper.place_save
  end
end
