# frozen_string_literal: true

require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @current_user = users(:admin)
    sign_in @current_user
    @movie = movies(:star_wars)
  end

  test 'should create rating for movie' do
    post ratings_url, params: { rating: { movie_id: @movie.id, value: 2 } }

    assert_redirected_to controller: 'movies', action: 'index'
    assert_equal 2, @movie.user_rate(@current_user)
  end

  test 'should update rating for movie if exists' do
    @movie.ratings.create!(user: @current_user, value: 5)

    post ratings_url, params: { rating: { movie_id: @movie.id, value: 3 } }

    assert_redirected_to controller: 'movies', action: 'index'
    assert_equal 3, @movie.user_rate(@current_user)
  end
end
