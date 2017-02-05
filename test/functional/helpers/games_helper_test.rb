class GamesHelperTest < ActionView::TestCase
	def test_mine_count_should_be_empty_string_if_mine_count_is_0
		cell = Cell.new(0,0,0)

		assert_equal '', mine_count(cell)
	end

	def test_mine_count_should_not_be_empty_string_if_mine_count_is_not_0
		cell = Cell.new(0,0,1)

		assert_equal 1, mine_count(cell)
	end
end
