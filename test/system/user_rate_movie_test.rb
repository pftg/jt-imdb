# frozen_string_literal: true

require 'application_system_test_case'

class UserRateMovieTest < ApplicationSystemTestCase
  setup do
    sign_in(users(:user))

    @movie = movies(:star_wars)
  end

  test 'visiting the index' do
    visit movies_url
    within "tr#movie_#{@movie.id}" do
      click_on '7'

      assert_selector 'b', text: '7'
    end
  end

  private

  def sign_in(user = users(:admin))
    visit new_user_session_path
    fill_in 'Email Address', with: user.email
    fill_in 'Password', with: 'welcome'
    click_on 'Log in'
  end
end
