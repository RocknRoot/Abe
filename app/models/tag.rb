class Tag < ActiveRecord::Base
  has_many :term_tags
  has_many :terms, :through => :term_tags
  attr_accessible :name

  scope :ordered, order(:name)
end
