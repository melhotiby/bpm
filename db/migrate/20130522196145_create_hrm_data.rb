class CreateHrmData < ActiveRecord::Migration
  def change
    create_table :hrm_data_points do |t|
      t.integer :session_id
      t.integer :bpm
      t.datetime :reading_start_time
      t.datetime :reading_end_time
      t.integer :duration

      t.timestamps
    end
  end
end
