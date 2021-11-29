class CreateWorkoutTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_templates do |t|
      t.string :name
      t.string :progression_curve
      t.string :good_for
      t.string :bad_for

      t.timestamps
    end
  end
end
