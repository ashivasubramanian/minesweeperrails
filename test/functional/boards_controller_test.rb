require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
	test "should be successful" do
		get :new
		assert_response :success
	end

	test "should set mode to Beginner if no mode is present" do
		response = get :new
		mode = response.request.query_parameters[:board].mode
		assert_equal BoardModes::BEGINNER, mode 
	end

	test "should set mode to requested mode" do
		response = get :new, {:mode => "Intermediate"}
		mode = response.request.query_parameters[:board].mode
		assert_equal BoardModes::INTERMEDIATE, mode
	end
end
