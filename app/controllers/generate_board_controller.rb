class GenerateBoardController < ApplicationController

	def createNewBoard
		board = Board.new(params[:mode])
		
		mode_list = Array.new (3)
		mode_list[0] = "Beginner"
		mode_list[1] = "Intermediate"
		mode_list[2] = "Advanced"
		request.query_parameters[:modes] = mode_list
	end

end
