class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_sets, dependent: :destroy
  # acts_as_taggable_on :mental_state
  acts_as_taggable_on :pro
end
