class Place < ApplicationRecord
  has_many :reviews

  validates :place_name, presence: true
  validates :address, presence: true
end
