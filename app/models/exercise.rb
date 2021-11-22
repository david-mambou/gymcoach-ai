class Exercise < ApplicationRecord
  belongs_to :station
  has_many :workouts, through: :workout_sets
end
