# frozen_string_literal: true

class Movie < ApplicationRecord
  CATEGORIES = %w[
    action adventure animation biography comedy crime documentary drama family fantasy film\ noir history
    horror music musical mystery romance sci-fi short sport superhero thriller war western
  ].freeze

  has_many :ratings, dependent: :delete_all
  validates :category, presence: true, inclusion: CATEGORIES
end
