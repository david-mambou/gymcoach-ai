class WorkoutSet < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
  enum difficulty: { easy: 0, moderate: 1, difficult: 2 }
end
