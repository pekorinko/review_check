class ResultsController < ApplicationController
  def new; end

  def create
    url = params[:url]
    url = url.split(';tbs:lrf:')[0] if url.include?(';tbs:lrf:')
    url = url.split('mv:[[')[0] if url.include?('mv:[[')
    place_data_scraper = MyTools::PlaceDataScraper.new(url)
    place = place_data_scraper.save_place
    place_data_scraper.save_review(place.id)
    check_credibility = MyTools::CheckCredibility.new(place.id)
    @result = check_credibility.credibility
  end
end
