class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.string :discount_type
      t.string :discount_on
      t.integer :discount_precentage

      t.timestamps
    end
  end
end
