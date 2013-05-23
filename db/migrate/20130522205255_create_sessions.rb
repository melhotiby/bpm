class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.integer :duration

      t.timestamps
    end
  end
end
