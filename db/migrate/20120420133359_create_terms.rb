class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name
      t.references :user
      t.references :category
      t.references :parent
      t.boolean :public
      t.string :type
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
    add_index :terms, :user_id
    add_index :terms, :category_id
    add_index :terms, :parent_id
  end
end
