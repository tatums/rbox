class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :title
      t.string :slug
      t.timestamps
    end
    add_index :states, :slug, unique: true
  end
end
