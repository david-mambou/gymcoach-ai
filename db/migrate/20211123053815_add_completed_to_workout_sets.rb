class AddCompletedToWorkoutSets < ActiveRecord::Migration[6.1]
  def change
    add_column :workout_sets, :completed, :boolean
  end
end
