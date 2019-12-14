# frozen_string_literal: true

require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  test 'increment ratings count per movie' do
    movie = movies(:lord_of_the_rings)

    movie.ratings.create!(user: users(:admin))

    assert_equal 2, movie.ratings_count
  end
end
