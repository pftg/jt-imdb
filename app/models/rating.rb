class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie, inverse_of: :ratings, counter_cache: true

  validates :value, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
end
