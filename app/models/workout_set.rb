class WorkoutSet < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
  enum difficulty: { easy: 0, moderate: 1, difficult: 2 }
  validates :nb_of_reps, :weight, numericality: {greater_than_or_equal_to: 0}
end
