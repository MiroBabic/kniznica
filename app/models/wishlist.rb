class Wishlist < ApplicationRecord
  belongs_to :author
  belongs_to :publisher
  belongs_to :user_id
end
