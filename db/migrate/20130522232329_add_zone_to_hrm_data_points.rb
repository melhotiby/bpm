class AddZoneToHrmDataPoints < ActiveRecord::Migration
  def change
    add_column :hrm_data_points, :zone, :integer
  end
end
