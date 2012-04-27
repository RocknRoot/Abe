class Term < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments, :dependent => :destroy
  attr_accessible :created_at, :name, :public, :type, :updated_at
end
