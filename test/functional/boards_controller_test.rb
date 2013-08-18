require 'test_helper'
require 'board_builder'

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
		response = get :new, :board => {:mode_name => 'Intermediate'}
		assert_select "option[value=Intermediate][selected]"
	end

	test "should set board into session" do
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)

		get :new

		assert_equal mock_board, session[@request.session_options[:id]], 'Board not set into session.'
		Board.unstub(:new)
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

	test "it should not render mine count when the board is first loaded" do
	 	get :new
	 	assert_select "#board td", count: 81
	 	assert_select "#board td", "&nbsp;"
	end

	test "it should render mine count JSON when the user clicks on a mine cell" do
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(2, 2).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)
		get :new

	 	response = get :reveal, :row => 2, :column => 2, :format => :json
		assert_equal '{"mine_count":-1}', response.body

		Board.unstub(:new)
	end

	test "it should render mine count JSON when the user clicks on a non-mine cell" do
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(2, 2).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)
		get :new

		response = get :reveal, :row => 2, :column => 1, :format => :json
		assert_equal '{"mine_count":1}', response.body

		Board.unstub(:new)
	end

end
