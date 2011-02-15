require 'Board'
require 'BoardModes'

class GenerateBoardController < ApplicationController

	def createNewBoard
		mode = params[:mode]
		if mode == 'Beginner'
			mode = BoardModes::BEGINNER
		elsif mode == 'Intermediate'
			mode = BoardModes::INTERMEDIATE
		elsif mode == 'Advanced'
			mode = BoardModes::ADVANCED
		end
		board = Board.new(mode)
		request.query_parameters[:board] = board
		
		mode_list = [:Beginner, :Intermediate, :Advanced] 
		request.query_parameters[:modes] = mode_list
	end

end
