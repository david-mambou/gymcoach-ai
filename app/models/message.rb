class Message < ApplicationRecord
  # workout and workout set optional, only if message is card
  belongs_to :workout, optional: true
  belongs_to :workout_set, optional: true
  enum category: [:submit, :receive, :card_workout, :card_chart], _default: "submit"
end
