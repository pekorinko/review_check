class ResultsController < ApplicationController
  def new; end

  def create
    url = params[:url]

    #ここでURLを正規表現できれいにする
    url = url.split('mv')[0] if url.include?('mv')
    puts '----------------'
    puts url
    puts '----------------'
    place_data_scraper = MyTools::PlaceDataScraper.new(url)
    place = place_data_scraper.save_place
    place_data_scraper.save_review(place.id)
    check_credibility = MyTools::CheckCredibility.new(place.id)
    @result = check_credibility.credibility
  end
end
