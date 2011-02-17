class Category < ActiveRecord::Base
  has_many :terms
  has_many :subcategories, :class_name => "Category",
    :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Category"
end
