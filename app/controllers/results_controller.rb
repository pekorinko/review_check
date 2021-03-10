class ResultsController < ApplicationController
  # def index
  #   @results = Result.all
  # end

  # def new
  #   @results = Result.new
  # end

  def create
    url = params[:url]
    @place = MyTools::PlaceDataScraper.new(url).scrape
  end
    @review = Review.find(params[:id])
  def show

  end

  def result_params
    p "***************************"
    p params
    params.require(:result).permit(:url)
  end

end
