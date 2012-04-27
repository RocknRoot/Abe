class TermNotepad < Term
  def abstract
    return content[0, 255]
  end
end
