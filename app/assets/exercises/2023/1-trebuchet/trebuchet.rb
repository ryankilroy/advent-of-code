@digit_words = []
@digit_words[1] = 'one'
@digit_words[2] = 'two'
@digit_words[3] = 'three'
@digit_words[4] = 'four'
@digit_words[5] = 'five'
@digit_words[6] = 'six'
@digit_words[7] = 'seven'
@digit_words[8] = 'eight'
@digit_words[9] = 'nine'

def main
	input_path = "#{__dir__}/input"
	puzzle_input = File.read(input_path)
	
	sum = 0
	
	values = parse_input(puzzle_input)
	values.each do |val|
		sum += val.to_i
	end
	
	puts sum
end

def digit_word_to_int(word)
	digit_int = ''
	@digit_words.each_with_index do |w, i|
		if word == w || word.to_i == i
			digit_int = i
		end
	end
	return digit_int
end

def parse_input(input, include_digit_names = false)
	digits_as_words = []
	(1..9).each do |digit|
		digits_as_words[digit-1] = @digit_words[digit]
	end
	digit_regex = include_digit_names ? /\d/ : /\d|#{digits_as_words.join('|')}/
	reversed_digit_regex = include_digit_names ? /\d/ : /\d|#{digits_as_words.map(&:reverse).join('|')}/
	digits = []
	input.split("\n").each_with_index do |line, i|
		first_digits_match = line.scan(digit_regex)
		last_digits_match = line.reverse.scan(reversed_digit_regex)
		puts "#{line}: #{first_digits_match.first}, #{last_digits_match.first}"
		digits[i] = "#{digit_word_to_int(first_digits_match.first)}#{digit_word_to_int(last_digits_match.first.reverse)}"
	end
	return digits
end

main