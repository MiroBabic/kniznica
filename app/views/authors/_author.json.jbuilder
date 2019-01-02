json.extract! author, :id, :name, :country, :birth_year, :dead_year, :created_at, :updated_at
json.url author_url(author, format: :json)
