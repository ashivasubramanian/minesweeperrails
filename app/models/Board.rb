require 'BoardModes'

class Board

	attr_accessor :mode, :rows

	def initialize(mode)
		@mode = mode
	end

end