class CatRentalRequest < ActiveRecord::Migration

  def change
    create_table :cat_rental_requests do |t|

      t.integer :cat_id, :null => false
      t.date :start_date, :null => false
      t.date :end_date, :null => false
      t.string :status, :default => "PENDING", :null => false

      t.timestamp
    end
    add_index :cat_rental_requests, :cat_id
  end
end
