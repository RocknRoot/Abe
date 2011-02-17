class CreateTerms < ActiveRecord::Migration
  def self.up
    create_table :terms do |t|
      t.integer :category
      t.string :name
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :terms
  end
end
