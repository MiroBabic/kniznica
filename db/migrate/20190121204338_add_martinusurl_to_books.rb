class AddMartinusurlToBooks < ActiveRecord::Migration[5.2]
  def change
  	add_column :books, :martinus_url, :string
  	add_column :books, :martinus_data, :jsonb
  end
end
