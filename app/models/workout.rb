class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :workout_template
  has_many :workout_sets, dependent: :destroy
  has_many :messages, dependent: :nullify
  has_many :exercises, through: :workout_sets
  enum status: { recommended: 0, active: 1, finished: 2, cancelled: 3 }

  amoeba do
    enable
    exclude_association :exercises
    # include_association :pros_and_cons
    include_association :workout_sets
  end

  # return latest workout for matching routine
  def self.latest_workout_for_routine(next_routine)
    return Workout.where("routine_tags = ?", next_routine).first
  end
end
