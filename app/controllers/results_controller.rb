class ResultsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
  end

  def create
    # url = params[:url]
    # @place = MyTools::PlaceDataScraper.new(url).scrape
  end

end
