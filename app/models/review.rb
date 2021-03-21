class Review < ApplicationRecord
  belongs_to :place, optional: true
  validates :count, presence: true
  validates :star, presence: true
end
