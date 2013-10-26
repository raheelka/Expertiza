module CountAnalytic
  def self.unique_character_count(item)
    self.item.gsub(/[^0-9A-Za-z ]/, '').downcase.split.uniq.count
  end

  def self.character_count(item)
    self.item.bytesize
  end

  def self.word_count(item)
    self.item.gsub(/[^0-9A-Za-z]/, ' ').split.count
  end

end