class Review < ApplicationRecord
  belongs_to :place
  validates :count, presence: true
  validates :star, presence: true
end
