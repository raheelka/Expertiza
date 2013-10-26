require 'analytic/assignment_team_analytic'
require 'analytic/common_analytic'

module AssignmentAnalytic
  include CommonAnalytic
  #====== general statistics ======#
  def num_participants
    self.participants.count
  end

  def num_teams
    self.teams.count
  end

  #==== number of team reviews ====#
  def total_num_team_reviews
    team_review_counts.inject(:+)
  end

  def average_num_team_reviews
    total_num_team_reviews.to_f/num_teams
  rescue ZeroDivisionError
    0
  end

  def max_num_team_reviews
    team_review_counts.max
  end

  def min_num_team_reviews
    team_review_counts.min
  end

  #=========== score ==============#
  def average_team_score
    self.team_scores.inject(:+).to_f/num_teams
  rescue ZeroDivisionError
    0
  end

  def max_team_score
    self.team_scores.max
  end

  def min_team_score
    self.team_scores.min
  end


  def team_review_counts
    #list = Array.new
    #self.teams.each do |team|
    #  list << team.num_reviews
    #end
    list = extract_from_list self.teams, :num_reviews
    (list.empty?) ? [0] : list
  end

  def team_scores
    #list = Array.new
    #self.teams.each do |team|
    #  list << team.average_review_score
    #end
    list = extract_from_list self.teams, :average_review_score
    (list.empty?) ? [0] : list
  end

  #return all questionnaire types associated this assignment
  def questionnaire_types
    questionnaire_type_list = Array.new
    self.questionnaires.each do |questionnaire|
      if !self.questionnaires.include?(questionnaire.type)
        questionnaire_type_list << questionnaire.type
      end
    end
    questionnaire_type_list
  end

  #return questionnaire of a type related to the assignment
  #assumptions: only 1 questionnaire of each type exist which should be the case
  #def questionnaire_of_type(type_name_in_string)
  #  self.questionnaires.each do |questionnaire|
  #    if questionnaire.type == type_name_in_string
  #      return questionnaire
  #    end
  #  end
  #end

  #return questionnaire of a type related to the assignment
  #assumptions: only 1 questionnaire of each type exist which should be the case
  def questionnaire_of_type(type_name_in_string)
    self.questionnaires.find { |questionnaire| questionnaire == type_name_in_string }
  end

  ##helper function do to verify the assumption made above
  #def self.questionnaire_unique?
  #  self.all.each do |assignment|
  #    assignment.questionnaire_types.each do |questionnaire_type|
  #      questionnaire_list = Array.new
  #      assignment.questionnaires.each do |questionnaire|
  #        if questionnaire.type == questionnaire_type
  #          questionnaire_list << questionnaire
  #        end
  #        if questionnaire_list.count > 1
  #          return false
  #        end
  #      end
  #    end
  #  end
  #  return true
  #end

  #helper function do to verify the assumption made above
  def self.questionnaire_unique?
    self.all.each do |assignment|
      questionnaires = assignment.questionnaires
      return false if questionnaires.uniq{|q| q.type}.length < questionnaires.length
    end
    return true
  end

  def has_review_questionnaire?
    questionnaire_types.include?("ReviewQuestionnaire")
  end

  def review_questionnaire
    questionnaire_of_type("ReviewQuestionnaire")
  end

end
