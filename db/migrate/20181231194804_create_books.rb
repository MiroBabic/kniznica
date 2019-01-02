class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.references :author, index: true, foreign_key: true
      t.references :publisher, index: true, foreign_key: true
      t.integer :publish_year
      t.integer :rating
      t.string :note
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
