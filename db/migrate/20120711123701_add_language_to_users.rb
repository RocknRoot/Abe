class AddLanguageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :language, :string, :default => "en"
    User.all.each { |u|
      u.language = "en"
      u.save
    }
  end
end
