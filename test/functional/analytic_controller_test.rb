require 'test_helper'

class AnalyticControllerTest < ActionController::TestCase
  include AnalyticHelper
  fixtures :courses,:teams,:users,:participants,:assignments,:nodes,:tree_folders, :roles
  fixtures :system_settings, :permissions, :roles_permissions
  fixtures :content_pages, :controller_actions, :site_controllers, :menu_items

  def setup
    @controller = AnalyticController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:user] = users(:superadmin)
    Role.rebuild_cache
    AuthController.set_current_role(users(:superadmin).role_id,@request.session)
  end

  def test_assignment_list
    post :assignment_list, :course_id => courses(:course1).id
    assignment_list = Array.new
    assignment_list.push(["Assignment 1",676884579])
    returned_assignment_list = JSON.parse(@response.body)
    assert_equal assignment_list,returned_assignment_list
    assert_response :success
    post :assignment_list, :course_id => courses(:course2).id
    assignment_list = Array.new
    assignment_list.push(["Assignment 2", 827400667])
    returned_assignment_list = JSON.parse(@response.body)
    assert_equal assignment_list,returned_assignment_list
    assert_response :success
  end

  def test_team_list
    post :team_list, :assignment_id => Assignment.first.id
    teams_list = Array.new
    teams_list.push(["Assignment1Team1",19665722])
    teams_list.push(["Assignment1Team2",405095042])
    returned_teams_list = JSON.parse(@response.body)
    assert_equal teams_list,returned_teams_list
    assert_response :success
    post :team_list, :assignment_id => assignments(:assignment2).id
    teams_list = Array.new
    teams_list.push(["team4", 538862539])
    teams_list.push(["team5", 1048245868])
    teams_list.push(["team6", 159237885])
    teams_list.push(["team7", 276076361])
    returned_teams_list = JSON.parse(@response.body)
    assert_equal teams_list,returned_teams_list
    assert_response :success
  end
end