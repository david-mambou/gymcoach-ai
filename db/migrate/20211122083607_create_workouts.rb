class CreateWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :workouts do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :template
      t.date :day
      t.text :pros_and_cons
      t.integer :mental_state

      t.timestamps
    end
  end
end
