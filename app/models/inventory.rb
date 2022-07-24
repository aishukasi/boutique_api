class Inventory < ApplicationRecord
  # Assocation
  belongs_to :category, class_name: 'Category', foreign_key: :category_name, primary_key: :name

  # Validation
	validates :skuid, presence: true, uniqueness: true
	validates :brand, presence: true
	validates :category_name, presence: true
	validates :list_price, presence: true
end
