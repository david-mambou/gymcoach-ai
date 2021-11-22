class CreateWorkoutSets < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_sets do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true
      t.integer :nb_of_reps
      t.integer :order_index
      t.float :weight
      t.integer :difficulty

      t.timestamps
    end
  end
end
