class Result < ApplicationRecord
  belongs_to :place
  belongs_to :user, optional: true
end
