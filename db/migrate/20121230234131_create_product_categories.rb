class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.references :category
      t.references :product

      t.timestamps
    end
    add_index :product_categories, :category_id
    add_index :product_categories, :product_id
  end
end
