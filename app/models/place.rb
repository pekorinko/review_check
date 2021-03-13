class Place < ApplicationRecord
<<<<<<< HEAD
  has_many :reviews
=======
  validates :place_name, presence: true
  validates :address, presence: true

  attr_reader :place_name, :address

  def initialize(place_name, address)
    @place_name = place_name
    @address = address
  end
>>>>>>> 6e23f5216bd5a541ac1a577253f9d340480c43b4
end
