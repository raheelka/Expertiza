require 'analytic/response_analytic'
require 'analytic/common_analytic'

module AssignmentTeamAnalytic
  include CommonAnalytic
  #======= general ==========#
  def num_participants
    self.participants.count
  end

  def num_reviews
    puts "IN NUM RE"
    self.responses.count
  end

  #========== score ========#
  def average_review_score
    puts "IN AVG RE"
    self.num_reviews == 0  ? 0 : review_scores.inject(:+).to_f/num_reviews
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
    self.num_reviews == 0 ? 0 : total_review_word_count.to_f/num_reviews
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
    num_reviews == 0 ? 0 : total_review_character_count.to_f/num_reviews
  end

  def max_review_character_count
    review_character_counts.max
  end

  def min_review_character_count
    review_character_counts.min
  end




  def review_character_counts
    #list = Array.new
    #self.responses.each do |response|
    #  list << response.total_character_count
    #end
    list = extract_from_list self.responses, :total_character_count
    (list.empty?) ? [0]: list
  end

  #return an array containing the score of all the reviews
  def review_scores
    #list = Array.new
    #self.responses.each do |response|
    #  list << response.get_average_score
    #end
    list = extract_from_list self.responses, :get_average_score
    (list.empty?) ? [0]: list
  end

  def review_word_counts
    #list = Array.new
    #self.responses.each do |response|
    #  list << response.total_word_count
    #end
    list = extract_from_list self.responses, :total_word_count
    (list.empty?) ? [0]: list
  end

  #======= unused ============#
  ##return students in the participants
  #def student_list
  #  students = Array.new
  #  self.participants.each do |participant|
  #    if participant.user.role_id == Role.student.id
  #      students << participant
  #    end
  #  end
  #  students
  #end
  #
  #def num_students
  #  self.students.count
  #end

end
