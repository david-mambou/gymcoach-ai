class ChangeTitleToNameInExercises < ActiveRecord::Migration[6.1]
  def change
    rename_column :exercises, :title, :name
  end
end
