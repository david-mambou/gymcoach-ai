class Exercise < ApplicationRecord
  belongs_to :station
  has_many :workouts, through: :workout_sets
  has_one_attached :photo
  acts_as_taggable_on :muscles
end
