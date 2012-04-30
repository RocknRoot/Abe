class TermNotepad < Term
  def abstract
    if content == nil
      return ""
    end
    return content[0, 255]
  end
end
