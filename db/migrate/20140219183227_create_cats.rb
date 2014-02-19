class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.integer :age
      t.date :birthdate, :null => false
      t.string :color
      t.string :name, :null => false
      t.string :sex, :length => 1, :null => false

      t.timestamps
    end
  end
end
