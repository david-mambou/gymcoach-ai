class AddRoutineToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :routine, :string
  end
end
