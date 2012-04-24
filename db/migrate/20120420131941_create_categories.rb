class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.references :parent
      t.references :user

      t.timestamps
    end
    add_index :categories, :parent_id
    add_index :categories, :user_id
  end
end
