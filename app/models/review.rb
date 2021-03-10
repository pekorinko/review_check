class Review < ApplicationRecord
  validates :text, presence: true
  validates :count, presence: true
  validates :star, presence: true
end
