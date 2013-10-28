require 'analytic/question_analytic'
module QuestionnaireAnalytic

  #return all possible questionnaire types
  def self.types
    type_list = extract_from_list self.all, :type
    type_list.uniq
  end

  def num_questions
    self.questions.count
  end

  def questions_text_list
    extract_from_list self.questions, :txt
  end

  def word_count_list
    extract_from_list self.questions, :word_count_list
  end

  def total_word_count
    word_count_list.inject(:+)
  end

  def average_word_count
    total_word_count.to_f/num_questions
  end

  def character_count_list
    extract_from_list self.questions, :character_count
  end

  def total_character_count
    character_count_list.inject(:+)
  end

  def average_character_count
    total_character_count/num_questions
  end

# OLD COMPLEX METHOD [before refactoring]
=begin
     #return all possible questionnaire types
    def self.types
      type_list = Array.new
      self.all.each do |questionnaire|
        if !type_list.include?(questionnaire.type)
          type_list << questionnaire.type
        end
      end
      type_list
    end
=end
end
