class CreateTermNotepads < ActiveRecord::Migration
  def change
    create_table :term_notepads, :inherits => 'Term' do |t|
      t.text :content

      t.timestamps
    end
  end
end
