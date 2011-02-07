class BoardModes

	attr_accessor :rows, :columns, :mine_count

	private
	def initialize(rows, columns, mine_count)
		@rows = rows
		@columns = columns
		@mine_count = mine_count
	end

	public
	BEGINNER = BoardModes.new(9, 9, 10)
	INTERMEDIATE = BoardModes.new(16, 16, 40)
	ADVANCED = BoardModes.new(16, 30, 99)
	

end