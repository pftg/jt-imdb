# frozen_string_literal: true

require 'test_helper'

class MovieCarrierTest < ActiveSupport::TestCase
  test 'wrap movie scope with pre-calculated ratings' do
    @movie_carriers = MovieCarrier.wrap(Movie.all)
    assert_equal 5, @movie_carriers.first.ratings_sum
  end

  test 'wrap movie scope with pre-calculated rating from user' do
    @movie_carriers = MovieCarrier.wrap(Movie.all, user: users(:user))
    assert_equal 5, @movie_carriers.first.user_rate

    @movie_carriers = MovieCarrier.wrap(Movie.all, user: users(:admin))
    assert_nil @movie_carriers.first.user_rate
  end

  test 'calculates stats without cache' do
    @movie_carrier = MovieCarrier.new(movies(:star_wars), user: users(:user))
    assert_equal 5, @movie_carrier.user_rate

    @movie_carrier = MovieCarrier.new(movies(:star_wars), user: users(:admin))
    assert_nil @movie_carrier.user_rate
  end
end
