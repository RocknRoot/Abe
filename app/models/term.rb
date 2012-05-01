class Term < ActiveRecord::Base
  acts_as_taggable_on :tags
  attr_accessible :tag_list
  attr_accessible :created_at, :name, :public, :type, :content, :updated_at

  belongs_to :user
  belongs_to :category
  has_many :comments, :dependent => :destroy

  def self.factory(type)
    term = nil
    if type == "notepad"
      term = TermNotepad.new
      term.type = "TermNotepad"
    end
    return term
  end

  def abstract
    raise NotImplementedError
  end
end
