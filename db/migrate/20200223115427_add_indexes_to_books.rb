class AddIndexesToBooks < ActiveRecord::Migration[5.2]
  def change
  	add_index :books, :name
  	add_index :books, :id
  	add_index :books, :rating

  	add_index :publishers, :name
  	add_index :authors, :name
  end
end
