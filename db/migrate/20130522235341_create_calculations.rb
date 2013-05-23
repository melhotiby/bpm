class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.references :session
      t.integer :zone1_duration
      t.integer :zone2_duration
      t.integer :zone3_duration
      t.integer :zone4_duration
      t.integer :average_bpm
      t.integer :max_bpm
      t.integer :min_bpm

      t.timestamps
    end
    add_index :calculations, :session_id
  end
end
