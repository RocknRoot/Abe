class Comment < ActiveRecord::Base
  belongs_to :term
  belongs_to :user
  attr_accessible :content, :created_at
end
