require 'test_helper'
require 'board_builder'

class CellTest < Test::Unit::TestCase

	def test_cell_color_should_be_green_if_mine_count_is_1
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(0, 0).build()
		cell = board.cells[0][1]

		assert_equal 'green', cell.colour
	end

	def test_cell_color_should_be_green_if_mine_count_is_2
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(0, 0).with_mine_in(1, 0).build()
	
		cell = board.cells[0][1];
		assert_equal 'green', cell.colour	
	end

	def test_cell_colour_should_be_orange_if_mine_count_is_3
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(0, 0).with_mine_in(1, 0).with_mine_in(1, 1).build()

		cell = board.cells[0][1];
		assert_equal 'orange', cell.colour
	end

	def test_cell_colour_should_be_red_if_mine_count_is_4
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(0, 0).with_mine_in(1, 0)
							.with_mine_in(1, 1).with_mine_in(1, 2).build()

		cell = board.cells[0][1]
		assert_equal 'red', cell.colour
	end

	def test_cell_colour_should_be_red_if_mine_count_is_greater_than_4
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(0, 0).with_mine_in(1, 0)
							.with_mine_in(1, 1).with_mine_in(1, 2)
							.with_mine_in(2, 1).build()

		cell = board.cells[0][1]
		assert_equal 'red', cell.colour
	end

	def test_cell_colour_should_be_nil_if_mine_count_is_any_other_value
		board = BoardBuilder.new(BoardModes::BEGINNER).build()

		cell = board.cells[0][0]
		assert_nil cell.colour
	end

	def test_mine_count_in_json_should_be_empty_string_if_mine_count_is_0
		board = BoardBuilder.new(BoardModes::BEGINNER).build()

		cell = board.cells[0][0]
		assert_equal '{"row":0,"column":0,"mine_count":"","cell_colour":null}', cell.to_json
	end

	def test_mine_count_in_json_should_not_be_empty_string_if_mine_count_is_not_0
		board = BoardBuilder.new(BoardModes::BEGINNER).with_mine_in(0, 0).build()

		cell = board.cells[0][1]
		assert_equal '{"row":0,"column":1,"mine_count":"1","cell_colour":"green"}', cell.to_json
	end
end
