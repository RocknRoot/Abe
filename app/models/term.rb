class Term < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :parent
  attr_accessible :created_at, :name, :public, :type, :updated_at
end
