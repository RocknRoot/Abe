class TermNotepad < ActiveRecord::Base
  inherits_from 'Term'
  attr_accessible :content
end
