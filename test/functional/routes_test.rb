require 'test_helper' 

class RoutesTest < ActionController::TestCase

	test "should route to game/new controller" do
		assert_generates("/games/new", {:controller => :games, :action => :new})
	end 

	test "should route to game/reveal controller" do
		assert_generates("/games/reveal", {:controller => :games, :action => :reveal})
	end
end
