require 'analytic/response_analytic'
require 'analytic/common_analytic'

module AssignmentTeamAnalytic
  include CommonAnalytic
  #======= general ==========#
  def num_participants
    self.participants.count
  end

  def num_reviews
    self.responses.count
  end

  #========== score ========#
  def average_review_score
    review_scores.inject(:+).to_f/num_reviews
  rescue ZeroDivisionError
    0
  end

  def max_review_score
    review_scores.max
  end

  def min_review_score
    review_scores.min
  end

  #======= word count =======#
  def total_review_word_count
    review_word_counts.inject(:+)
  end

  def average_review_word_count
    total_review_word_count.to_f/num_reviews
  rescue ZeroDivisionError
    0
  end

  def max_review_word_count
    review_word_counts.max
  end

  def min_review_word_count
    review_word_counts.min
  end

  #===== character count ====#
  def total_review_character_count
    review_character_counts.inject(:+)
  end

  def average_review_character_count
    total_review_character_count.to_f/num_reviews
  rescue ZeroDivisionError
    0
  end

  def max_review_character_count
    review_character_counts.max
  end

  def min_review_character_count
    review_character_counts.min
  end


  def review_character_counts
    list = extract_from_list self.responses, :total_character_count
    (list.empty?) ? [0] : list
  end

  #return an array containing the score of all the reviews
  def review_scores
    list = extract_from_list self.responses, :get_average_score
    (list.empty?) ? [0] : list
  end

  def review_word_counts
    list = extract_from_list self.responses, :total_word_count
    (list.empty?) ? [0] : list
  end

end
