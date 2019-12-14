class MovieCarrier
  delegate_missing_to :@movie

  def initialize(movie, cached_stats: nil, user: nil)
    @movie = movie
    @cached_ratings_stats = cached_stats || calculate_stats(movie, user)
  end

  def total
    @cached_ratings_stats[:ratings_sums][@movie.id]
  end

  def current_user_rate
    @cached_ratings_stats[:values][@movie.id]
  end

  def to_param
    @movie.to_param
  end

  def to_partial_path
    @movie.to_partial_path
  end

  def to_model
    @movie.to_model
  end

  def self.wrap(movie_scope, user: nil)
    movies = movie_scope.to_a

    cache = {
      ratings_sums: calculate_totals(movies),
      values: current_user_rates(movies, user)
    }

    movies.map { |movie| MovieCarrier.new(movie, cached_stats: cache, user: user) }
  end

  private

  def calculate_stats(movie, user)
    {
      ratings_sums: { movie.id => movie.ratings_sum },
      values: { movie.id => movie.user_rate(user) },
    }
  end

  def self.current_user_rates(movies, user)
    return {} unless user
    Hash[
      Rating
        .where(movie_id: movies.collect(&:id))
        .where(user_id: user.id)
        .group(:movie_id)
        .pluck(:movie_id, :value)
    ]
  end

  def self.calculate_totals(movies)
    Rating
      .where(movie_id: movies.collect(&:id))
      .group(:movie_id)
      .sum(:value)
  end
end
