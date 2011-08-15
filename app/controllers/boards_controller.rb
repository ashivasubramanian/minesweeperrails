require 'Board'
require 'BoardModes'

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
		
		mode_list = [BoardModes::BEGINNER.name, BoardModes::INTERMEDIATE.name, BoardModes::ADVANCED.name] 
		request.query_parameters[:modes] = mode_list
	end

end
