require 'analytic/assignment_analytic'
require 'analytic/common_analytic'

module CourseAnalytic
  include CommonAnalytic

  #====== general statistics ======#
  def num_participants
    self.participants.count
  end

  def num_assignments
    self.assignments.count
  end

  #===== number of assignment teams ====#
  def total_num_assignment_teams
    assignment_team_counts.inject(:+)
  end

  def average_num_assignment_teams
    total_num_assignment_teams.to_f/num_assignments
  rescue ZeroDivisionError
    0
  end

  def max_num_assignment_teams
    assignment_team_counts.max
  end

  def min_num_assignment_teams
    assignment_team_counts.min
  end

  #===== assignment score =====#
  def average_assignment_score
    assignment_average_scores.inject(:+).to_f/num_assignments
  rescue ZeroDivisionError
    0
  end

  def max_assignment_score
    assignment_max_scores.max
  end

  def min_assignment_score
    assignment_min_scores.min
  end

  #======= reviews =======#
  def assignment_review_counts
    list = extract_from_list self.assignments, :total_num_team_reviews
    (list.empty?) ? [0] : list
  end

  def total_num_assignment_reviews
    assignment_review_counts.inject(:+)
  end

  def average_num_assignment_reviews
    total_num_assignment_reviews.to_f/num_assignments
  end

  def max_num_assignment_reviews
    assignment_review_counts.max
  end

  def min_num_assignment_reviews
    assignment_review_counts.min
  end


  def assignment_team_counts
    list = extract_from_list self.assignments, :num_teams
    (list.empty?) ? [0] : list
  end

  def assignment_average_scores
    list = extract_from_list self.assignments, :average_team_score
    (list.empty?) ? [0] : list

  end

  def assignment_max_scores
    list = extract_from_list self.assignments, :max_team_score
    (list.empty?) ? [0] : list
  end

  def assignment_min_scores
    list = extract_from_list self.assignments, :min_team_score
    (list.empty?) ? [0] : list
  end

end
