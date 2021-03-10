class Place < ApplicationRecord
  validates :place_name, presence: true
  validates :address, presence: true

  attr_reader :place_name, :address

  def initialize(place_name, address)
    @place_name = place_name
    @address = address
  end
end
