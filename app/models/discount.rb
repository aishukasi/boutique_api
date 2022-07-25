class Discount < ApplicationRecord
  # Validation
  validates :discount_type, presence: true
  validates :discount_on, presence: true
  validates :discount_type, uniqueness: {scope: :discount_on}
end
