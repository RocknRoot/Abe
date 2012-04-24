class Category < ActiveRecord::Base
  belongs_to :parent
  belongs_to :user
  attr_accessible :name
end
