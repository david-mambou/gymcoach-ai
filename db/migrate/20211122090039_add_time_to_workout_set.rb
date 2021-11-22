class AddTimeToWorkoutSet < ActiveRecord::Migration[6.1]
  def change
    add_column :workout_sets, :time, :integer
  end
end
