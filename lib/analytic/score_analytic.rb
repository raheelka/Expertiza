module ScoreAnalytic
  def unique_character_count
    CountAnalytic.unique_character_count(self.comments)
  end

  def character_count
    CountAnalytic.character_count(self.comments)
  end

  def word_count
    CountAnalytic.word_count(self.comments)
  end
end
