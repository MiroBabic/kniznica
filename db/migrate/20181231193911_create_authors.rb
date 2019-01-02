class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :country
      t.integer :birth_year
      t.integer :dead_year

      t.timestamps
    end
  end
end
