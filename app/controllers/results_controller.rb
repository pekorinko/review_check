class ResultsController < ApplicationController
  def new; end

  def create
    url = params[:url]
    place_data_scraper = MyTools::PlaceDataScraper.new(url)
    @place_id = place_data_scraper.save_place
    place_data_scraper.save_review(@place_id)
    check_credibility = MyTools::CheckCredibility.new(@place_id)
    @result = check_credibility.credibility
    puts '---------------------------'
    puts @result
  end
end
