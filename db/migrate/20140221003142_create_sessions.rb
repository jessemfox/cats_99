class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id, :presence => true
      t.string :session_token, :presence => true

      t.timestamps
    end

    add_index :sessions, :user_id
  end
end
