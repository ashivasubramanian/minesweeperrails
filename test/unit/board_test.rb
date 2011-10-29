require 'test/unit'
require 'test_helper'
require 'board_builder'

class BoardTest < Test::Unit::TestCase

	def test_beginner_board_shall_have_10_rows_by_10_columns
		board = Board.new(BoardModes::BEGINNER)
		assert_equal 9, board.mode.rows
		assert_equal 9, board.mode.columns
	end

	def test_intermediate_board_shall_have_16_rows_by_16_columns
		board = Board.new(BoardModes::INTERMEDIATE)
		assert_equal 16, board.mode.rows
		assert_equal 16, board.mode.columns
	end

	def test_advanced_board_shall_have_16_rows_by_30_columns
		board = Board.new(BoardModes::ADVANCED)
		assert_equal 16, board.mode.rows
		assert_equal 30, board.mode.columns
	end

	def test_beginner_mode_shall_have_10_mines
		board = Board.new(BoardModes::BEGINNER)
		assert_equal 10, board.cells.flatten.count {|value| value.mine_count == -1}
	end

	def test_intermediate_mode_shall_have_40_mines
		board = Board.new(BoardModes::INTERMEDIATE)
		assert_equal 40, board.cells.flatten.count {|value| value.mine_count == -1}
	end

	def test_advanced_mode_shall_have_99_mines
		board = Board.new(BoardModes::ADVANCED)
		assert_equal 99, board.cells.flatten.count {|value| value.mine_count == -1}
	end

	def test_should_calculate_mine_count_for_central_tile
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(2, 4).build()

		assert_equal 1, board.cells[1][3].mine_count
		assert_equal 1, board.cells[1][4].mine_count
		assert_equal 1, board.cells[1][5].mine_count
		assert_equal 1, board.cells[2][3].mine_count
		assert_equal 1, board.cells[2][5].mine_count
		assert_equal 1, board.cells[3][3].mine_count
		assert_equal 1, board.cells[3][4].mine_count
		assert_equal 1, board.cells[3][5].mine_count
	end

	def test_should_calculate_mine_count_for_top_left_tile
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(0, 0).build()

		assert_equal 1, board.cells[0][1].mine_count
		assert_equal 1, board.cells[1][0].mine_count
		assert_equal 1, board.cells[1][1].mine_count
	end

	def test_should_calculate_mine_count_for_top_right_tile
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(0, 8).build()

		assert_equal 1, board.cells[0][7].mine_count
		assert_equal 1, board.cells[1][7].mine_count
		assert_equal 1, board.cells[1][8].mine_count
	end

	def test_should_calculate_mine_count_for_bottom_left_tile
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(8, 0).build()

		assert_equal 1, board.cells[8][1].mine_count
		assert_equal 1, board.cells[7][0].mine_count
		assert_equal 1, board.cells[7][1].mine_count
	end

	def test_should_calculate_mine_count_for_bottom_right_tile
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(8, 8).build()

		assert_equal 1, board.cells[8][7].mine_count
		assert_equal 1, board.cells[7][7].mine_count
		assert_equal 1, board.cells[7][8].mine_count
	end

end