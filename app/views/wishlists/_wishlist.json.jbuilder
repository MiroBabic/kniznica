json.extract! wishlist, :id, :name, :author_id, :publisher_id, :publish_year, :martinus_url, :image_url, :note, :pages, :price, :expected_release, :user_id_id, :created_at, :updated_at
json.url wishlist_url(wishlist, format: :json)
