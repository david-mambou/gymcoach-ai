class AddNameToWorkoutSets < ActiveRecord::Migration[6.1]
  def change
    add_column :workout_sets, :name, :string
  end
end
