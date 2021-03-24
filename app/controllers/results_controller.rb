class ResultsController < ApplicationController
  def new; end

  def create
    url = params[:url]
    place_data_scraper = MyTools::PlaceDataScraper.new(url)
    place_id = place_data_scraper.save_place
    place_data_scraper.save_review(place_id)
    check_credibility = MyTools::CheckCredibility.new(place_id)
    @result_credibility = check_credibility.credibility
  end
end
