class RemoveParentFromTerm < ActiveRecord::Migration
  def up
    remove_column :terms, :parent_id
  end

  def down
  end
end
