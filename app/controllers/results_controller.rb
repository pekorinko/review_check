class ResultsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    puts 'new'
    @place = MyTools::PlaceDataScraper.new(@url)
  end

  def create
    puts 'create'
    url = params[:url]
    puts url
    url = 'https://www.google.com/search?q=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C+%E5%9B%BD%E7%AB%8B&rlz=1C5CHFA_enJP939JP939&oq=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&aqs=chrome..69i57.4119j0j7&sourceid=chrome&ie=UTF-8#lrd=0x6018e3951c8fde6f:0x429b84dcae3b48f6,1,,,'
    @place = MyTools::PlaceDataScraper.new(url).scrape
  end

end
