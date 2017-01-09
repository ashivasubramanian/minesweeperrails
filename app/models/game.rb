class Game

	attr_accessor :board

	def initialize(mode)
		@board = Board.new mode
	end

	def reveal_cell(row, column)
		{:cell => @board.cells[row][column].as_json}
	end

end