class Place < ApplicationRecord
  has_many :reviews
  has_many :results

  validates :place_name, presence: true
  validates :address, presence: true
end
