require 'board_modes'
require 'cell'

class Board

	attr_accessor :mode, :mode_name, :cells

	def initialize(mode)
		@mode = mode
		@mode_name = mode.name
		@cells = Array.new(@mode.rows) {|index| Array.new @mode.columns}
		fill_required_cells_with_mines
		fill_non_mine_cells_with_numbers
	end

	private
	def fill_required_cells_with_mines
		mine_count = 0
		while mine_count < @mode.mine_count do 
			row = rand(@mode.rows)
			column = rand(@mode.columns)
			unless (@cells[row][column])
				@cells[row][column] = Cell.new(-1)
				mine_count += 1
			end
		end
	end

	def fill_non_mine_cells_with_numbers
		@mode.rows.times do |row|
			@mode.columns.times do |column|
				unless @cells[row][column] && @cells[row][column].mine_count == -1
					@cells[row][column] = calculate_mine_count_around_cell(row, column)
				end
			end
		end
	end

	def calculate_mine_count_around_cell(row, column)
		mine_count = 0
		row_index = @mode.rows - 1
		column_index = @mode.columns - 1
		if column > 0
			mine_count += 1 if @cells[row][column - 1] && @cells[row][column - 1].mine_count == -1
		end
		if column < column_index
			mine_count += 1 if @cells[row][column + 1] && @cells[row][column + 1].mine_count == -1
		end
		
		if row > 0
			if column > 0
				mine_count += 1 if @cells[row - 1][column - 1] && @cells[row - 1][column - 1].mine_count == -1
			end
			mine_count += 1 if @cells[row - 1][column] && @cells[row - 1][column].mine_count == -1
			if column < column_index
				mine_count += 1 if @cells[row - 1][column + 1] && @cells[row - 1][column + 1].mine_count == -1
			end
		end

		if row < row_index
			if column > 0
				mine_count += 1 if @cells[row + 1][column - 1] && @cells[row + 1][column - 1].mine_count == -1
			end
			mine_count += 1 if @cells[row + 1][column] && @cells[row + 1][column].mine_count == -1
			if column < column_index
				mine_count += 1 if @cells[row + 1][column + 1] && @cells[row + 1][column + 1].mine_count == -1
			end
		end

		Cell.new(mine_count)
	end

end