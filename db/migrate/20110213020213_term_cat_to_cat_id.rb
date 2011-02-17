class TermCatToCatId < ActiveRecord::Migration
  def self.up
    change_table :terms do |t|
      t.rename :category, :category_id
    end
  end

  def self.down
    change_table :terms do |t|
      t.rename :category_id, :category
    end
  end
end
