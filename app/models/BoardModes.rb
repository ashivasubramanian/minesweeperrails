class BoardModes

	attr_accessor :name, :rows, :columns, :mine_count

	private
	def initialize(name, rows, columns, mine_count)
		@name = name
		@rows = rows
		@columns = columns
		@mine_count = mine_count
	end

	public
	BEGINNER = BoardModes.new('Beginner', 9, 9, 10)
	INTERMEDIATE = BoardModes.new('Intermediate', 16, 16, 40)
	ADVANCED = BoardModes.new('Advanced', 16, 30, 99)
end