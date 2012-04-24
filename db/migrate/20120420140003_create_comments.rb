class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :term
      t.text :content
      t.references :user
      t.datetime :created_at

      t.timestamps
    end
    add_index :comments, :term_id
    add_index :comments, :user_id
  end
end
