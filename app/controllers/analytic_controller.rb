class AnalyticController < ApplicationController
  include CourseHelper
  include AnalyticHelper
  before_filter :init

  def index
  end

  def init
    init_scope_analytics
    init_graph_analytics
  end

  def init_scope_analytics
    # Available attributes for each type of chart
    @available_analytics = {:course => CourseAnalytic.available_analytics,
                            :assignment => AssignmentAnalytic.available_analytics,
                            :team => AssignmentTeamAnalytic.available_analytics}
  end

  def init_graph_analytics
    @available_attributes = {:bar => ['num_assignment_teams',
                                      'assignment_score',
                                      'num_assignment_reviews',
                                      'num_team_reviews',
                                      'num_team_reviews',
                                      'team_score',
                                      'review_score',
                                      'review_word_count',
                                      'review_character_count'],
                             :scatter => [],
                             :line => [],
                             :pie => []
    }

    # Create list of data_types for bar chart. Rest charts not implemented
    @available_analytics[:bar] = aggregate_functions.inject([]) do |result, statistic|
      @available_attributes[:bar].each { |data_type| result.push("#{statistic}_#{data_type}") }
      result
    end
  end

  def required_analytics(scope, graph_type)
    @available_analytics[scope] & @available_analytics[graph_type]
  end

  def graph_analytics_list
    scope = params[:scope].to_sym
    graph_type = params[:type].to_sym
    analytics_list = required_analytics(scope, graph_type)
    render :json => analytics_list.sort!
  end

  def get_graph_data_bundle
    render :json => nil if incomplete_params?(params)

    scope = params[:scope]
    graph_type = params[:type]
    id = params[:id]
    data_type = params[:data_type]
    puts "DATA #{data_type}"

    graph_method_name = {'line' => 'line_graph_data',
                         'bar' => 'bar_chart_data',
                         'scatter' => 'scatter_plot_data',
                         'pie' => 'pie_graph_data'}
    graph_data = send(graph_method_name[graph_type], scope, id, data_type)
    render :json => graph_data
  end

  def course_list
    courses = associated_courses(session[:user])
    course_list = courses.map { |course| [course.name, course.id] }
    puts "here"
    puts sort_by_name(course_list)
    render :json => sort_by_name(course_list)
  end

  def assignment_list
    course = Course.find(params[:course_id], :include => :assignments)
    assignments = course.assignments
    assignment_list = assignments.map { |assignment| [assignment.name, assignment.id] }
    render :json => sort_by_name(assignment_list)
  end

  def team_list
    assignment = Assignment.find(params[:assignment_id])
    teams_list = assignment.teams.map { |team| [team.name, team.id] }
    render :json => sort_by_name(teams_list)
  end

end
