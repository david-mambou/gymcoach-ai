class CreateExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :exercises do |t|
      t.references :station, null: false, foreign_key: true
      t.string :title
      t.integer :muscle_group
      t.string :good_for
      t.string :bad_for

      t.timestamps
    end
  end
end
