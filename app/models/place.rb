class Place < ApplicationRecord
  has_many :reviews
  has_one :result

  validates :place_name, presence: true
  validates :address, presence: true
end
