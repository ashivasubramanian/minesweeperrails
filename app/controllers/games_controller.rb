require 'board'
require 'board_modes'

class GamesController < ApplicationController

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
		@game = Game.new(mode)
		session[request.session_options[:id]] = :dummy
		session[request.session_options[:id]] = @game
		
		logger.info "Board generated for request id #{request.session_options[:id]} is: \n#{@game.board}"

		mode_list = [BoardModes::BEGINNER.name, BoardModes::INTERMEDIATE.name, BoardModes::ADVANCED.name] 
		request.query_parameters[:modes] = mode_list
	end

	def reveal
		row = params[:row].to_i
		column = params[:column].to_i	

		session_id_from_cookie = request.session_options[:id]
		game = session[session_id_from_cookie]
		respond_with game.reveal_cell(row, column)
	end

end
