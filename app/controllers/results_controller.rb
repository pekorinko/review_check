class ResultsController < ApplicationController
  def new; end

  def create
    url = params[:url]
    place_data_scraper = MyTools::PlaceDataScraper.new(url)
    place_data_scraper.save_review
    place_data_scraper.save_place
  end
end
