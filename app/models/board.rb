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

	def to_s
		board_as_string = ''
		@cells.each do |row|
			row.each do |column|
				board_as_string += column.mine_count.to_s + ' '
			end
			board_as_string += "\n"
		end	
		board_as_string
	end

	def contiguous_empty_cells(row, column)
		return [] if @cells[row][column].mine_count != 0
		empty_cells = surrounding_empty_cells(row, column)
		already_processed_cells = [@cells[row][column]]
		empty_cells | get_contiguous_empty_cells(empty_cells, already_processed_cells)[0]
	end

	private
	def fill_required_cells_with_mines
		mine_count = 0
		while mine_count < @mode.mine_count do 
			row = rand(@mode.rows)
			column = rand(@mode.columns)
			unless (@cells[row][column])
				@cells[row][column] = Cell.new(row, column, -1)
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
		mine_count = surrounding_cells(row, column).count{|cell| cell.mine_count == -1}
		Cell.new(row, column, mine_count)
	end

	def surrounding_cells(row, column)
		surrounding_cells = []
		row_index = @mode.rows - 1
		column_index = @mode.columns - 1
		if column > 0
			surrounding_cells << @cells[row][column - 1] if @cells[row][column - 1]
		end
		if column < column_index
			surrounding_cells << @cells[row][column + 1] if @cells[row][column + 1]
		end
		
		if row > 0
			if column > 0
				surrounding_cells << @cells[row - 1][column - 1] if @cells[row - 1][column - 1]
			end
			surrounding_cells << @cells[row - 1][column] if @cells[row - 1][column]
			if column < column_index
				surrounding_cells << @cells[row - 1][column + 1] if @cells[row - 1][column + 1]
			end
		end

		if row < row_index
			if column > 0
				surrounding_cells << @cells[row + 1][column - 1] if @cells[row + 1][column - 1]
			end
			surrounding_cells << @cells[row + 1][column] if @cells[row + 1][column]
			if column < column_index
				surrounding_cells << @cells[row + 1][column + 1] if @cells[row + 1][column + 1]
			end
		end
		surrounding_cells
	end

	def surrounding_empty_cells(row, column)
		surrounding_cells(row, column).select{|cell| cell.mine_count == 0}
	end

	def get_contiguous_empty_cells(empty_cells, already_processed_cells)
		empty_cells.each do |cell|
			cells = surrounding_empty_cells(cell.row, cell.column)
			cells.reject! {|cell| empty_cells.member? cell}
			cells.reject! {|cell| already_processed_cells.member? cell}
			already_processed_cells = already_processed_cells | [cell]
			empty_cells = empty_cells | cells
			contiguous_empty_cells, already_processed_cells = get_contiguous_empty_cells(cells, already_processed_cells)
			empty_cells = empty_cells | contiguous_empty_cells
		end
		[empty_cells, already_processed_cells]
	end
end
