class Game

	attr_accessor :board

	def initialize(mode)
		@board = Board.new mode
	end

	def reveal_cell(row, column)
		if (@board.cells[row][column].mine_count == 0)
			contiguous_empty_cells = @board.contiguous_empty_cells(row, column)
			all_cells_to_be_revealed = contiguous_empty_cells << @board.cells[row][column]
			return all_cells_to_be_revealed
		end
		[@board.cells[row][column]]
	end

end
