class Cell

	attr_accessor :mine_count

	def initialize(mine_count)
		@mine_count = mine_count
	end

	def colour
		return 'green' if mine_count == 1 or mine_count == 2
		return 'orange' if mine_count == 3
		return 'red' if mine_count >= 4
	end

	def as_json(options = {})
		mine_count = (@mine_count == 0) ? '' : @mine_count
		cell_colour = colour()
		{ :mine_count => mine_count.to_s, :cell_colour => cell_colour }
	end
end
