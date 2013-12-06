class Game

	attr_accessor :board, :status

	def initialize(mode)
		@board = Board.new mode
		@status = 'IN_PROGRESS'
	end

	def reveal_cell(row, column)
		@status = 'GAME_OVER' if (@board.cells[row][column].mine_count == -1)
		{:status => @status, :cell => @board.cells[row][column].as_json}
	end

end