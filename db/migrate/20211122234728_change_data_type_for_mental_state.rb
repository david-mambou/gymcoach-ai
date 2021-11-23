class ChangeDataTypeForMentalState < ActiveRecord::Migration[6.1]
  def change
    change_column :workouts, :mental_state, :string
  end
end
