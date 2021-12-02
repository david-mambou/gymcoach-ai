class AddDescriptionToExercises < ActiveRecord::Migration[6.1]
  def change
    add_column :exercises, :description, :text
    add_column :exercises, :instruction, :text
  end
end
