require 'board'
require 'board_modes'

class BoardsController < ApplicationController

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
		
		mode_list = [BoardModes::BEGINNER.name, BoardModes::INTERMEDIATE.name, BoardModes::ADVANCED.name] 
		request.query_parameters[:modes] = mode_list
	end

	def reveal
		board = session[request.session_options[:id]]
		board.cells.each do |row|
			row.each do |column|
				print column.mine_count
			end
			p ""
		end	
	end

end
