class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :gender
      t.integer :age
      t.integer :hr_zone1_min
      t.integer :hr_zone1_max
      t.integer :hr_zone2_min
      t.integer :hr_zone2_max
      t.integer :hr_zone3_min
      t.integer :hr_zone3_max
      t.integer :hr_zone4_min
      t.integer :hr_zone4_max

      t.timestamps
    end
  end
end
