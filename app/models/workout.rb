class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_sets, dependent: :destroy
  has_many :messages, dependent: :nullify
  has_many :exercises, through: :workout_sets
  enum status: { not_done: 0, in_progress: 1, completed: 2 }
  # acts_as_taggable_on :mental_state
  acts_as_taggable_on :pros_and_cons
  acts_as_taggable_on :emotional_states

  amoeba do
    enable
    exclude_association :exercises
    # include_association :pros_and_cons
    include_association :workout_sets
  end
end
