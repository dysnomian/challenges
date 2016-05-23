module Parens
	extend self

	# def evaluate(string)
	# 	string.
	# 		split("").
	# 		reduce(initial_state(string)) {|state, token| parse(state, token)}.
	# 		fetch(:longest_substring, nil)
	# end
	#
	# def initial_state(string)
	# 	{
	# 		input: string,           # the original input to the .evaluate function
	# 		current_substring: ""    # the substring being parsed (may not be valid)
	# 		longest_substring: "",   # the longest valid string evaluated
	# 		last_token:        nil,  
	# 		open_parens:       0,    # number of valid open parens
	# 		close_parens:      0,    # number of valid close parens
	# 	}
	# end
	#
	# # parse_token :: ParserState -> Character -> ParserState
	# def parse(state, token)
	# 	state[:current_token] = token
	#
	# 	if token == "("
	# 		state = parse_open_paren(state)
	# 	elsif token == ")"
	# 		state = parse_close_paren(state)
	# 	else
	# 		raise Exception.new("Invalid input.")
	# 	end
	#
	# 	state
	# end
	#
	# def parse_open_paren(state)
	# 	state[:current_substring] << "("
	# 	state[:open_parens] += 1
	# 	state
	# end
	#
	# def parse_close_paren(state)
	# 	if state[:open_parens] == state[:close_parens]
	# 		state[:longest_substring] = state[:current_substring]
	# 		state[:current_substring] << "("
	# 	end
	#
	# 	if state[:close_parens] < state[:open_parens]
	# 	  state[:close_parens] += 1
	# 	  state[:current_substring] << "("
	# 	else #when invalid
	# 		state[:current_substring] = ""
	# 	end
	#
	# 	state
	# end

	def trim_invalid_bounding_parens(string)
		trim_invalid_ending_parens(string)
		trim_invalid_starting_parens(string)
	end

	def trim_invalid_starting_parens(string)
		string.split("")
			.drop_while { |c| c == ")" }
			.join("")
	end

	def trim_invalid_ending_parens(string)
		string.split("")
			.reverse
			.drop_while { |c| c == "(" }
			.reverse
			.join("")
	end

	def trim_outer_parens(string)
		a = string.split("")
		a.delete_at(0)
		a.delete_at(-1)
		a.join("")
	end

	def balanced?(string)
		a = string.split("")
		open = a.select {|paren| paren == "("}.count
		close = a.select {|paren| paren == ")"}.count 
		open == close
	end

	def look_ahead(string)
		puts "LOOKING AHEAD:\n"

		if string == ""
		puts "Nothing left to evaluate. Look ahead is successful!\n" 
		else puts "Looking at #{string}.\n"
		end

		return true if string == ""

		string = trim_invalid_bounding_parens(string)
		string = trim_outer_parens(string)
		balanced?(string) ? look_ahead(string) : false
	end

	def evaluate(string)
		string = trim_invalid_bounding_parens(string)
		until balanced?(string) && look_ahead(string) == true
			string = trim_outer_parens(string)
			string = trim_invalid_bounding_parens(string)
		end
		string == "" ? nil : string
	end
end
