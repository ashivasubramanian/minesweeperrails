require 'board'
require 'board_modes'

class BoardsController < ApplicationController

	respond_to :html, :json

	def new 
		mode = params[:board][:mode_name] if params[:board]
		if mode.nil? || mode == 'Beginner'
			mode = BoardModes::BEGINNER
		elsif mode == 'Intermediate'
			mode = BoardModes::INTERMEDIATE
		elsif mode == 'Advanced'
			mode = BoardModes::ADVANCED
		end
		@board = Board.new(mode)
		session[request.session_options[:id]] = @board
		
		board_as_string = ''
		@board.cells.each do |row|
			row.each do |column|
				board_as_string += column.mine_count.to_s + ' '
			end
			board_as_string += "\n"
		end	
		logger.info "Board generated for request id #{request.session_options[:id]} is:"
		logger.info board_as_string

		mode_list = [BoardModes::BEGINNER.name, BoardModes::INTERMEDIATE.name, BoardModes::ADVANCED.name] 
		request.query_parameters[:modes] = mode_list
	end

	def reveal
		row = params[:row].to_i
		column = params[:column].to_i	

		board = session[request.session_options[:id]]
		cell = board.cells[row][column]
		respond_with cell
	end

end
