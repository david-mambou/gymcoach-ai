class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :category
      t.text :content
      t.references :workout, null: false, foreign_key: true
      t.references :workout_set, null: false, foreign_key: true
      t.text :user_review
      t.integer :user_rating

      t.timestamps
    end
  end
end
