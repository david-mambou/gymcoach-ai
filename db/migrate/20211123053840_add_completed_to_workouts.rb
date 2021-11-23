class AddCompletedToWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_column :workouts, :completed, :boolean
  end
end
