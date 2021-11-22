class CreateStations < ActiveRecord::Migration[6.1]
  def change
    create_table :stations do |t|
      t.float :base_incremental_weight

      t.timestamps
    end
  end
end
