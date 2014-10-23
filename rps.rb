# rps.rb

# Command-line Rock Paper Scissors game implemented in Ruby with OOP.
# User plays against the compputer that randomly genereates its moves.

class Computer
	attr_accessor :name, :move

	def initialize
		@name = "Computer"
	end

	def make_move
		moves = ["P", "R", "S"]
		self.move = moves.sample
	end
end

class User
	attr_accessor :name, :move

	def initialize
		@name = "User"
	end

	def make_move
		puts "Choose one: (P/R/S)"
		# Check if move is valid.
		begin
			u_move = gets.chomp.upcase
		end until ["P", "R", "S"].include?(u_move)
		self.move = u_move
	end
end

class Game
	attr_accessor :p1, :p2, :winner

	def initialize(p1, p2)
		@p1 = p1
		@p2 = p2
		@winner = "No one"
	end

	# Announces the winner.
	def say_winner
		if self.winner == "No one"
			puts "It's a tie!"
		else
			puts "#{self.winner.name} won!"
		end
	end

	# Compare 2 player's moves and updates the winner.
	def compare(p1, p2)
		if p1.move == p2.move
			self.winner = "No one"
		elsif p1.move == "P"
			if p2.move == "R"
				self.winner = p1
			else
				self.winner = p2
			end
		elsif p1.move == "R"
	    if p2.move == "P"
	      self.winner = p2
	    else
	      self.winner = p1
	    end
		 elsif p1.move == "S"
	    if p2.move == "R"
	      self.winner = p2
	    else
	      self.winner = p1
	    end
	   end
	end

	def play
		loop do
			puts "Play Paper Rock Scissors!"
			
			# Both players make move.
			p1.make_move
			p2.make_move
			puts "#{p1.name} picked #{to_word(p1.move)} and #{p2.name} picked #{to_word(p2.move)}."

			# Compare and find the winner
			compare(p1, p2)

			# Announce winner.
			self.say_winner

			# Asks if user wants to play again.
			puts "Play again? (Y/N)"

			begin
				choice = gets.chomp.upcase
  		end until ["Y", "N"].include?(choice)

  		if choice == "N"
  			break
  		end
  	end
  end

  private

  # Takes a code (P/R/S) and converts it to the words "Paper", "Rock" or "Scissors".
	def to_word(code)
	  case code
	  when "P"
	    "Paper"
	  when "R"
	    "Rock"
	  when "S"
	    "Scissors"
	  end
	end

end

p1 = User.new
p2 = Computer.new
game = Game.new(p1, p2)
game.play