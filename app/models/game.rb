class Game

	attr_accessor :board

	def initialize(mode)
		@board = Board.new mode
	end

	def reveal_cell(row, column)
		@board.cells[row][column]
	end

end