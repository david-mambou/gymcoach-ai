class RemoveProAndConsFromWorkouts < ActiveRecord::Migration[6.1]
  def change
    remove_column :workouts, :pro_and_cons
    remove_column :workouts, :mental_state
    remove_column :exercises, :muscle_group
  end
end
