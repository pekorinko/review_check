class Review < ApplicationRecord
<<<<<<< HEAD
  belongs_to :place, optional: true
=======
  validates :text, presence: true
  validates :count, presence: true
  validates :star, presence: true
>>>>>>> 6e23f5216bd5a541ac1a577253f9d340480c43b4
end
