class BoardBuilder

	def initialize(mode)
		@board = Board.new(mode)
		@board.cells = [].fill(nil, @board.mode.rows) {|index| [].fill(nil, nil, @board.mode.columns)}
	end

	def with_mine_in(row, column)
		@board.cells[row][column] = -1
		self
	end

	def build
		@board.send(:fill_non_mine_cells_with_numbers)
		@board
	end
	
end