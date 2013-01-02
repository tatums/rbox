class CreateProductStates < ActiveRecord::Migration
  def change
    create_table :product_states do |t|
      t.references :product
      t.references :state

      t.timestamps
    end
  end
end
