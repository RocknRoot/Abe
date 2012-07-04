class PrepareCommentImplementation < ActiveRecord::Migration
  def up
    add_column :comments, :approved, :boolean, :default => true
    add_column :terms, :accept_comment, :boolean, :default => true
  end

  def down
    remove_column :comments, :approved
    remove_column :terms, :accept_comment
  end
end
