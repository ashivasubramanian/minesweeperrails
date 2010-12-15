require 'Board'

class GenerateBoardController < ApplicationController

	def createNewBoard
		board = Board.new(params[:mode])
		
		mode_list = [:Beginner, :Intermediate, :Advanced] 
		request.query_parameters[:modes] = mode_list
	end

end
