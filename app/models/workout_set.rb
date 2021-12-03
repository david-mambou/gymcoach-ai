class WorkoutSet < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
  enum difficulty: { "Easy" => 0, "Okay" => 1, "Hard" => 2, "Very Hard" => 3, "Failed" => 4 }
  validates :nb_of_reps, :weight, numericality: { greater_than_or_equal_to: 0 }

  # TODO: add current method
end
