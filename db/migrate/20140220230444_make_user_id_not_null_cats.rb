class MakeUserIdNotNullCats < ActiveRecord::Migration
  def change
    change_table :cats do |t|
      t.change :user_id, :integer, :null => false
    end
  end
end
