class ResultsController < ApplicationController
  # require 'place_data_scraper.rb'
  def index
  end

  def new
  end

  def create
    # url = params[:url]
    # @place = MyTools::PlaceDataScraper.new(url).scrape
  end

  def view
    @msg = 'こんにちは、世界！'
  end

end
