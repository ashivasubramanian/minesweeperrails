require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
	test "should be successful" do
		get :new
		assert_response :success
	end

	test "should set mode to Beginner if no mode is present" do
		response = get :new
		board = response.request.query_parameters[:board].mode
		assert_equal board, BoardModes::BEGINNER 
	end
end
