class RemoveTemplateFromWorkout < ActiveRecord::Migration[6.1]
  def change
    remove_column :workouts, :template
  end
end
