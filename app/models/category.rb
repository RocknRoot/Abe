class Category < ActiveRecord::Base
  belongs_to :parent
  belongs_to :user
  has_many :categories, :foreign_key => :parent_id, :dependent => :destroy
  attr_accessible :name, :parent_id
end
