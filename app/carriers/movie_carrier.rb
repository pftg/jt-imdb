# frozen_string_literal: true

class MovieCarrier
  delegate_missing_to :@movie

  def initialize(movie, cached_stats: nil, user: nil)
    @movie = movie
    @cached_ratings_stats = cached_stats || calculate_stats(movie, user)
  end

  def avg_rating
    @cached_ratings_stats[:avg_ratings][@movie.id]
  end

  def user_rate(_user = nil)
    @cached_ratings_stats[:values][@movie.id]
  end

  def text
    @movie.text&.truncate(25)
  end

  def to_param
    @movie.to_param
  end

  def to_model
    @movie.to_model
  end

  def self.wrap(movie_scope, user: nil)
    movies = movie_scope.to_a

    cache = {
      avg_ratings: calculate_totals(movies),
      values: current_user_rates(movies, user),
    }

    movies.map { |movie| MovieCarrier.new(movie, cached_stats: cache, user: user) }
  end

  private

  def calculate_stats(movie, user)
    {
      avg_ratings: { movie.id => movie.avg_rating },
      values: { movie.id => movie.user_rate(user) },
    }
  end

  def self.current_user_rates(movies, user)
    return {} if user.nil?

    Hash[
      Rating
        .where(movie_id: movies.collect(&:id))
        .where(user_id: user.id)
        .group(:movie_id, :value)
        .pluck(:movie_id, :value)
    ]
  end

  def self.calculate_totals(movies)
    Rating
      .where(movie_id: movies.collect(&:id))
      .group(:movie_id)
      .average(:value)
  end
end
