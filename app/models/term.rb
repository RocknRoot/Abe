class Term < ActiveRecord::Base
  attr_accessible :tag_names
  attr_accessible :created_at, :name, :public, :type, :content, :updated_at

  belongs_to :user
  belongs_to :category
  has_many :comments, :dependent => :destroy
  has_many :term_tags
  has_many :tags, :through => :term_tags

  after_save :assign_tags

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

  def tag_names
    return @tag_names || tags.ordered.map(&:name).join(', ')
  end

  def tag_names=(value)
    @tag_names = value
    assign_tags
  end

  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\s*,\s*/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end
end
