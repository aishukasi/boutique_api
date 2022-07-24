class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.integer :skuid
      t.string :brand
      t.string :category_name
      t.decimal :list_price , precision: 10, scale: 2

      t.timestamps
    end
    add_index :inventories, :skuid, unique: true
  end
end
