class ChangeColumnNullMessages < ActiveRecord::Migration[6.1]
  def change
    change_column_null :messages, :workout_id, true
    change_column_null :messages, :workout_set_id, true
  end
end
