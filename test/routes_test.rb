require 'test_helper' 

class RoutesTest < ActionController::TestCase

	test "should route to home page with mode set to Beginner if no mode is specified"  do
		assert_recognizes({:controller => "GenerateBoard", :action => "createNewBoard"}, '/mine/createBoard', {:mode => 'Beginner'})
	end

	test "should route to home page with specific mode if mode is specified" do
		assert_recognizes({:controller => "GenerateBoard", :action => "createNewBoard", :mode => 'Intermediate'}, '/mine/createBoard', {:mode => 'Intermediate'})
	end 
end
