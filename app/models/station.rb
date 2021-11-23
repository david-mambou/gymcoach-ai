class Station < ApplicationRecord
  has_many :exercises
  has_one_attached :photo
end
