json.extract! book, :id, :name, :author, :publisher, :publish_year, :rating, :note, :created_at, :updated_at
json.url book_url(book, format: :json)
