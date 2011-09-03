require 'test/unit'
require 'test_helper'

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
		assert_equal 10, board.cells.flatten.count {|value| value == -1}
	end

	def test_intermediate_mode_shall_have_40_mines
		board = Board.new(BoardModes::INTERMEDIATE)
		assert_equal 40, board.cells.flatten.count {|value| value == -1}
	end

	def test_advanced_mode_shall_have_99_mines
		board = Board.new(BoardModes::ADVANCED)
		assert_equal 99, board.cells.flatten.count {|value| value == -1}
	end

	def test_should_calculate_mine_count_for_central_tile
		board = Board.new(BoardModes::BEGINNER)
		board.cells = [
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, -1, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil]
					  ]
		board.send(:fill_non_mine_cells_with_numbers)

		assert_equal 1, board.cells[1][3]
		assert_equal 1, board.cells[1][4]
		assert_equal 1, board.cells[1][5]
		assert_equal 1, board.cells[2][3]
		assert_equal 1, board.cells[2][5]
		assert_equal 1, board.cells[3][3]
		assert_equal 1, board.cells[3][4]
		assert_equal 1, board.cells[3][5]
	end

	def test_should_calculate_mine_count_for_top_left_tile
		board = Board.new(BoardModes::BEGINNER)
		board.cells = [
						[-1, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil]
					  ]
		board.send(:fill_non_mine_cells_with_numbers)

		assert_equal 1, board.cells[0][1]
		assert_equal 1, board.cells[1][0]
		assert_equal 1, board.cells[1][1]
	end

	def test_should_calculate_mine_count_for_top_right_tile
		board = Board.new(BoardModes::BEGINNER)
		board.cells = [
						[nil, nil, nil, nil, nil, nil, nil, nil, -1], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil]
					  ]
		board.send(:fill_non_mine_cells_with_numbers)

		assert_equal 1, board.cells[0][7]
		assert_equal 1, board.cells[1][7]
		assert_equal 1, board.cells[1][8]
	end

	def test_should_calculate_mine_count_for_bottom_left_tile
		board = Board.new(BoardModes::BEGINNER)
		board.cells = [
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[-1, nil, nil, nil, nil, nil, nil, nil, nil]
					  ]
		board.send(:fill_non_mine_cells_with_numbers)

		assert_equal 1, board.cells[8][1]
		assert_equal 1, board.cells[7][0]
		assert_equal 1, board.cells[7][1]
	end

	def test_should_calculate_mine_count_for_bottom_right_tile
		board = Board.new(BoardModes::BEGINNER)
		board.cells = [
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil, nil],
						[nil, nil, nil, nil, nil, nil, nil, nil, -1]
					  ]
		board.send(:fill_non_mine_cells_with_numbers)

		assert_equal 1, board.cells[8][7]
		assert_equal 1, board.cells[7][7]
		assert_equal 1, board.cells[7][8]
	end

end