class AddRoutineTagsToWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_column :workouts, :routine_tags, :string
  end
end
