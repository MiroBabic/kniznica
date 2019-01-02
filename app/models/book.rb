class Book < ApplicationRecord
	belongs_to :author, optional: true
	belongs_to :publisher, optional: true
	belongs_to :user
end
