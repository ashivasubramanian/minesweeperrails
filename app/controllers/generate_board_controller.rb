class GenerateBoardController < ApplicationController

	def createNewBoard
		print 'woo'
		mode = request.query_parameters[:mode]
		print mode
		board = Board.new(mode)
	end

end
