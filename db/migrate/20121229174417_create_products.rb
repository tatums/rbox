class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :slug
      t.timestamps
    end
    add_index :products, :slug, unique: true
  end
end
