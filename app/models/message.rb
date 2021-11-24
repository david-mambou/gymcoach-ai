class Message < ApplicationRecord
  belongs_to :workout
  belongs_to :workout_set
  enum category: [:submit, :receive, :card_workout, :card_chart], _default: "submit"
end
