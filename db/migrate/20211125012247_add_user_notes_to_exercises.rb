class AddUserNotesToExercises < ActiveRecord::Migration[6.1]
  def change
    add_column :exercises, :user_notes, :string
  end
end
