json.extract! movie, :id, :title, :text, :category_id, :ratings_count, :ratings_sum, :created_at, :updated_at
json.url movie_url(movie, format: :json)
