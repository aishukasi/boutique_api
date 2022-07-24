class Category < ApplicationRecord
  # Association
  has_many :subs, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
  belongs_to :superior, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy, optional: :true
  has_many :Inventories, dependent: :destroy, class_name: 'Inventory', foreign_key: :category_name, primary_key: :name
  #has_one :discounts, dependent: :destroy

  # Validation
  validates :name, presence: true, uniqueness: true

  def ancestores
  	[superior, superior.try(:ancestores)].compact.flatten
  end
end
