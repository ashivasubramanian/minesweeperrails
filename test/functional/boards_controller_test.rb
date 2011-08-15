require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
	test "should be successful" do
		get :new
		assert_response :success
	end

	test "should generate board in Beginner mode if no mode is present" do
		response = get :new
		assert_select "option[value=Beginner][selected]"
	end

	test "should set mode to requested mode" do
		response = get :new, :board => {:mode_name => "Intermediate"}
		assert_select "option[value=Intermediate][selected]"
	end

	test "it should contain a New Game link" do
		get :new
		assert_select "a", "New Game"
		assert_select "a[href*=#{new_board_path}]"
	end

	test "it should contain a New Game link with the URL pointing to the current mode" do
		get :new
		assert_select 'a[href*=Beginner]'

		get :new, :board => {:mode_name => 'Intermediate'}
		assert_select 'a[href*=Intermediate]'

		get :new, :board => {:mode_name => 'Advanced'}
		assert_select 'a[href*=Advanced]'
	end

	test "it should have a text '(in same mode)' below the New Game link" do
		get :new
		assert_select 'td[class=newGameCell]' do # testing span is below New Game Link
			assert_select "a[href*=#{new_board_path}]"
			assert_select 'br'
			assert_select 'span[class=sameModeText]'
		end
		assert_select 'td[class=newGameCell] > span', '(in same mode)' # testing value of span
	end

	test "it should contain a listbox with three modes" do
		get :new
		assert_select "select > option", :count => 3
		assert_select "select > option:first-child", "Beginner"
		assert_select "select > option:nth-child(2)", "Intermediate"
		assert_select "select > option:last-child", "Advanced"
	end

	test "it should have mnemonics" do
		get :new
		assert_select "a[href*=#{new_board_path}][accesskey=n]"
		assert_select 'label[for=selectMode][accesskey=C]'
	end
end
