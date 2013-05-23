class AddIndexToHrmDataPoints < ActiveRecord::Migration
  def change
    add_index :hrm_data_points, :session_id
  end
end
