# frozen_string_literal: true

require 'application_system_test_case'

class MoviesTest < ApplicationSystemTestCase
  setup do
    sign_in(users(:admin))

    @movie = movies(:star_wars)
  end

  test 'visiting the index' do
    visit movies_url
    assert_selector 'h1', text: 'Movies'
  end

  test 'creating a Movie' do
    visit movies_url
    click_on 'New Movie'

    fill_in 'Category', with: @movie.category
    fill_in 'Text', with: @movie.text
    fill_in 'Title', with: @movie.title
    click_on 'Create Movie'

    assert_text 'Movie was successfully created'
    click_on 'Back'
  end

  test 'updating a Movie' do
    visit movies_url
    click_on 'Edit', match: :first

    fill_in 'Category', with: @movie.category
    fill_in 'Text', with: @movie.text
    fill_in 'Title', with: @movie.title
    click_on 'Update Movie'

    assert_text 'Movie was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Movie' do
    visit movies_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Movie was successfully destroyed'
  end

  private

  def sign_in(user = users(:admin))
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'welcome'
    click_on 'Log in'
  end
end
