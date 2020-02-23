module StaticPagesHelper
	def get_book_count
		Book.all.count
	end
end
