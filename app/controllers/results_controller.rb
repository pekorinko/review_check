class ResultsController < ApplicationController
  # require 'place_data_scraper.rb'
  def index
    @msg = 'URLを入力'
  end

  def new
  end

  def create
    # url = params[:url]
    # @place = MyTools::PlaceDataScraper.new(url).scrape
  end

end
