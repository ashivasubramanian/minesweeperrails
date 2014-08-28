class BoardBuilder

	def initialize(mode)
		@board = Board.new(mode)
		@board.cells = Array.new(@board.mode.rows) {|index| Array.new @board.mode.columns}
	end

	def with_mine_in(row, column)
		@board.cells[row][column] = Cell.new(row, column, -1)
		self
	end

	def build
		@board.send(:fill_non_mine_cells_with_numbers)
		@board
	end
	
end