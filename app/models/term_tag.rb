class TermTag < ActiveRecord::Base
  belongs_to :term
  belongs_to :tag
end
