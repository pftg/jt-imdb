# frozen_string_literal: true

json.extract! movie, :id, :title, :text, :category, :ratings_count, :created_at, :updated_at
json.url movie_url(movie, format: :json)
