class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name
      t.references :user
      t.references :category
      t.boolean :public
      t.binary :content
      t.string :type
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
    add_index :terms, :user_id
    add_index :terms, :category_id
  end
end
