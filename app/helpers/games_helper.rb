module GamesHelper
	def mine_count(cell)
		return (cell.mine_count == 0) ? '' : cell.mine_count
	end
end
