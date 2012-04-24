class CreateTermTags < ActiveRecord::Migration
  def change
    create_table :term_tags do |t|
      t.references :term
      t.references :tag

      t.timestamps
    end
    add_index :term_tags, :term_id
    add_index :term_tags, :tag_id
  end
end
