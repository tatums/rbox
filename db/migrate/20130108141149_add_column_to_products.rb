class AddColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :backstage_product_id, :integer
  end
end
