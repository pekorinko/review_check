class Review < ApplicationRecord
  belongs_to :place, optional: true
end
