class AddIndexesToSessions < ActiveRecord::Migration
  def change
    add_index :sessions, :id
    add_index :sessions, :created_at
  end
end