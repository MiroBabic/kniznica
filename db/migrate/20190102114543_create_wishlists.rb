class CreateWishlists < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlists do |t|
      t.string :name
      t.references :author, foreign_key: true
      t.references :publisher, foreign_key: true
      t.integer :publish_year
      t.string :martinus_url
      t.string :image_url
      t.string :note
      t.integer :pages
      t.string :price
      t.string :expected_release
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
