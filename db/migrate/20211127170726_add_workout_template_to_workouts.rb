class AddWorkoutTemplateToWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_reference :workouts, :workout_template, null: false, foreign_key: true
  end
end
