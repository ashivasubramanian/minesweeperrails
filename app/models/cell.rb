class Cell

	attr_accessor :mine_count, :row, :column

	def initialize(row, column, mine_count)
		@row = row
		@column = column
		@mine_count = mine_count
	end

	def colour
		return 'green' if mine_count == 1 or mine_count == 2
		return 'orange' if mine_count == 3
		return 'red' if mine_count >= 4
	end

	def <=>(cell)
		return 0 if row == cell.row && column == cell.column
		if row == cell.row
			return -1 if column < cell.column
			return 1 if column > cell.column
		end
		return -1 if row < cell.row
		return 1 if row > cell.row
	end
end
