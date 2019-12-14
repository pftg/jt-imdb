# frozen_string_literal: true

require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @movie = movies(:star_wars)
  end

  test 'should get index' do
    get movies_url
    assert_response :success
    assert_select 'tr.movie', count: 3
  end

  test 'should get index filtered by category' do
    get movies_url(category: @movie.category)
    assert_response :success
    assert_select 'tr.movie', count: 2
  end

  test 'should get new' do
    get new_movie_url
    assert_response :success
  end

  test 'should create movie' do
    assert_difference('Movie.count') do
      post movies_url, params: {
        movie: {
          category: @movie.category,
          text: @movie.text,
          title: @movie.title
        }
      }
    end

    assert_redirected_to movie_url(Movie.last)
  end

  test 'should show movie' do
    get movie_url(@movie)
    assert_response :success
  end

  test 'should get edit' do
    get edit_movie_url(@movie)
    assert_response :success
  end

  test 'should update movie' do
    patch movie_url(@movie), params: {
      movie: {
        category: @movie.category,
        text: @movie.text,
        title: @movie.title
      }
    }
    assert_redirected_to movie_url(@movie)
  end

  test 'should destroy movie' do
    assert_difference('Movie.count', -1) do
      delete movie_url(@movie)
    end

    assert_redirected_to movies_url
  end
end
