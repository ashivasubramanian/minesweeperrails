require 'test/unit'
require 'test_helper'
require 'board_builder'
require 'board_modes'
require 'mocha/test_unit'

class GameTest < Test::Unit::TestCase

	def test_reveal_cell_should_return_the_correct_Cell_object_if_user_clicks_on_a_non_mine_cell
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(1,1).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)

		game = Game.new BoardModes::BEGINNER
		expected = [mock_board.cells[0][0]]

		output = game.reveal_cell(0,0)

		assert_equal expected, output
		Board.unstub(:new)
	end

	def test_reveal_cell_should_return_the_correct_Cell_object_if_user_clicks_on_a_mine_cell
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(1,1).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)
		
		game = Game.new BoardModes::BEGINNER
		expected = [mock_board.cells[1][1]]

		output = game.reveal_cell(1,1)

		assert_equal expected, output
		Board.unstub(:new)
	end

	def test_board_should_be_initialized_on_game_initialization
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)

		Game.new BoardModes::BEGINNER

		Board.unstub(:new)
	end

	def test_reveal_cell_should_return_a_map_of_contiguous_empty_cells_if_cell_has_zero_mine_count
		mock_board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(0,3).with_mine_in(1,3).with_mine_in(2,3)
				.with_mine_in(3,3).with_mine_in(3,2).with_mine_in(3,1).with_mine_in(3,0).build
		Board.expects(:new).with(BoardModes::BEGINNER).returns(mock_board)

		game = Game.new BoardModes::BEGINNER
		expected_map = [mock_board.cells[0][1], mock_board.cells[1][0], mock_board.cells[1][1], mock_board.cells[0][0]] 

		output_map = game.reveal_cell(0,0)

		assert_equal expected_map, output_map
		Board.unstub(:new)
	end

end
