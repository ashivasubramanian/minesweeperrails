require 'test/unit'
require 'test_helper'
require 'board_builder'
require 'board_modes'

class GameTest < Test::Unit::TestCase

	def test_game_should_have_In_Progress_status_when_game_is_initialized
		game = Game.new BoardModes::BEGINNER

		assert_equal 'IN_PROGRESS', game.status
	end

	def test_should_have_Game_Over_status_when_user_clicks_on_mine
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(1,1).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)

		game = Game.new BoardModes::BEGINNER

		game.reveal_cell(1,1)

		assert_equal 'GAME_OVER', game.status
		Board.unstub(:new)
	end

	def test_reveal_cell_should_return_a_map_with_In_Progress_game_status
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(1,1).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)

		game = Game.new BoardModes::BEGINNER
		expected_map = {:status => 'IN_PROGRESS', :cell => {:row => 0, :column => 0, :mine_count => '1', :cell_colour => "green"}}

		output = game.reveal_cell(0,0)

		assert_equal expected_map, output
		Board.unstub(:new)
	end

	def test_reveal_cell_should_return_a_map_with_Game_Over_game_status
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(1,1).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)
		
		game = Game.new BoardModes::BEGINNER
		expected_map = {:status => 'GAME_OVER', :cell => {:row => 1, :column => 1, :mine_count => "-1", :cell_colour => nil}}

		output = game.reveal_cell(1,1)

		assert_equal expected_map, output
		Board.unstub(:new)
	end

	def test_board_should_be_initialized_on_game_initialization
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)

		Game.new BoardModes::BEGINNER

		Board.unstub(:new)
	end

end