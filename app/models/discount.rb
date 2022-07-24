class Discount < ApplicationRecord
  # Association
  #belongs_to :category

  # Validation
  validates :discount_type, presence: true
  validates :discount_on, presence: true
end
