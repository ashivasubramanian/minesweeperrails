require 'BoardModes'

class Board

	attr_accessor :mode, :mode_name

	def initialize(mode)
		@mode = mode
		@mode_name = mode.name
	end

end