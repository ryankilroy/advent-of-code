@games = []
RED_MAX = 12
GREEN_MAX = 13
BLUE_MAX = 14

def main
	input_path = "#{__dir__}/input"
	puzzle_input = File.read(input_path)
	parse_input(puzzle_input)
	sum_impossible = 0
	sum_powers = 0
	@games.each_with_index do |game, i|
		sum_impossible += i if game && !game[:flag]
		if game
			power = 1
			game[:min_required].keys.each do |colour|
				power *= game[:min_required][colour]
			end
			sum_powers += power
		end
	end
	puts sum_impossible
	puts sum_powers
end

def parse_input(input)
	input.split("\n").each do |game_line|
		game_line_match = game_line.match(/Game (\d+):(.*)/).captures
		game_id = game_line_match.first.to_i
		@games[game_id] = {}
		@games[game_id][:details] = []
		@games[game_id][:min_required] = {red: 0, green: 0, blue: 0}
		@games[game_id][:flag] = false
		game_details_strings = game_line_match.last.split(';')
		game_details_strings.each_with_index do |game, index|
			game_details = {}
			game_details[:blue] = game.match(/(\d+) blue/).captures.first.to_i if game.include?('blue')
			game_details[:red] = game.match(/(\d+) red/).captures.first.to_i if game.include?('red')
			game_details[:green] = game.match(/(\d+) green/).captures.first.to_i if game.include?('green')
			if game_details[:blue] && game_details[:blue] > BLUE_MAX || 
				game_details[:red] && game_details[:red] > RED_MAX ||
				game_details[:green] && game_details[:green] > GREEN_MAX
				@games[game_id][:flag] = true
			end
			[:red, :green, :blue].each do |colour|
				if game_details[colour] && game_details[colour] > @games[game_id][:min_required][colour] 
					@games[game_id][:min_required][colour] = game_details[colour]
				end
			end
			@games[game_id][:details][index] = game_details
		end
	end
end

main