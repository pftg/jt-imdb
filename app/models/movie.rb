# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :ratings, dependent: :delete_all
end
