class AnalyticController < ApplicationController
  include CourseHelper
  include AnalyticHelper
  before_filter :init

  def index

  end

  def init
    #all internal not use by the page
    @available_scope_types = [:courses, :assignments, :teams]
    @available_graph_types = [:line, :bar, :pie, :scatter]
    @available_courses = associated_courses(session[:user])

    #Hash of available method name of the data mining methods with different type of selection
    @available_data_types= {:course => CourseAnalytic.instance_methods.map(&:to_s),
                            :assignment => AssignmentAnalytic.instance_methods.map(&:to_s),
                            :team => AssignmentTeamAnalytic.instance_methods.map(&:to_s)}
    #Available statistics
    @available_statistics = ['min', 'max', 'total', 'average']

    # Available attributes for each type of chart
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
    @available_data_types[:bar] = @available_statistics.inject([]) do |result, statistic|
      @available_attributes[:bar].each { |data_type| result.push("#{statistic}_#{data_type}") }
      result
    end
  end

  def graph_data_type_list
    #cross checking @available_data_type[chart_type] with @available_data_type[scope]
    scope = params[:scope].to_sym
    graph_type = params[:type].to_sym
    data_type_list = @available_data_types[scope] & @available_data_types[graph_type]
    data_type_list.sort!
    render :json => data_type_list
  end

  def incomplete_params?(params)
    params[:id].nil? or params[:data_type].nil?
  end

  def get_graph_data_bundle
    a = Time.now
    puts "entered get "
    render :json => nil if incomplete_params?(params)

    scope = params[:scope]
    graph_type = params[:type]
    id = params[:id]
    data_type = params[:data_type]

    chart_method_name = {'line' => 'line_graph_data',
                         'bar' => 'bar_chart_data',
                         'scatter' => 'scatter_plot_data',
                         'pie' => 'pie_graph_data'}
    chart_data = send(chart_method_name[graph_type], scope, id, data_type)
    render :json => chart_data
    puts "Exiting get #{Time.now - a} #{chart_data.to_json}"
  end

  def course_list
    courses = associated_courses(session[:user])
    course_list = courses.map { |course| [course.name, course.id] }
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
    render :json => sort_by_name(team_list)
  end

end
