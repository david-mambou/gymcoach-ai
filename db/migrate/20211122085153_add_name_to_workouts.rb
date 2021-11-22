class AddNameToWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_column :workouts, :name, :string
  end
end
