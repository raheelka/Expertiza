require 'analytic/score_analytic'
module ResponseAnalytic
  def num_questions
    self.scores.count
  end

  #====== score =======#
  def average_score
    question_score_list.inject(:+)/num_questions
  rescue ZeroDivisionError
    0
  end

  def max_question_score
    question_score_list.max
  end

  def min_question_score
    question_score_list.min
  end

  #====== word count ======#
  def total_word_count
    word_count_list.inject(:+)
  end

  def average_word_count
    total_word_count.to_f/num_questions
  rescue ZeroDivisionError
    0
  end

  def max_word_count
    word_count_list.max
  end

  def min_word_count
    word_count_list.min
  end

  #====== character count ====#
  def total_character_count
    character_count_list.inject(:+)
  end

  def average_character_count
    total_character_count.to_f/num_questions
  end

  def max_character_count
    character_count_list.max
  end

  def min_character_count
    character_count_list.min
  end

  private
  #return an array of strings containing the word count of al the comments
  def word_count_list
    list = extract_from_list self.scores, :word_count
    (list.empty?) ? [0] : list
  end

  def character_count_list
    list = extract_from_list self.scores, :character_count
    (list.empty?) ? [0] : list
  end

  #return score for all of the questions in an array
  def question_score_list
    list = extract_from_list self.scores, :score
    (list.empty?) ? [0] : list
  end

  #return an array of strings containing all of the comments
  def comments_text_list
    extract_from_list self.scores, :comments
  end

end
