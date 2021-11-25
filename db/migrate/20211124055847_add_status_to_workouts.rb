class AddStatusToWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_column :workouts, :status, :integer
  end
end
