require 'test_helper' 

class RoutesTest < ActionController::TestCase

	test "should route to boards/new controller" do
		assert_generates("/boards/new", {:controller => :boards, :action => :new})
	end 
end
