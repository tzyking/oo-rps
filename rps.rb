# rps.rb

# Command-line Rock Paper Scissors game implemented in Ruby with OOP.
# User plays against the compputer that randomly genereates its moves.

# TODO: new class Hand that uses include Comparable

class Hand
	attr_accessor :move

	include Comparable

	def initialize(move)
		@move = move
	end

	def <=>(another_hand)
		if self.move == another_hand.move
			0
		elsif (self.move == "P" && another_hand.move == "R") || (self.move == "R" && another_hand.move == "S") ||
			(self.move == "S" && another_hand.move == "P")
			1
		else
			-1
		end
	end

end

class Player
	attr_accessor :name, :hand

	def initialize(n)
		@name = n
	end
end

class Computer < Player
	# Generates a random move.
	def make_move
		self.hand = Hand.new(Game::CHOICES.keys.sample)
	end
end

class User < Player
	# Asks user for his/her move.
	def make_move
		# Check if move is valid.
		begin
			puts "Choose one: (P/R/S)"
			u_move = gets.chomp.upcase
		end until Game::CHOICES.keys.include?(u_move)
		self.hand = Hand.new(u_move)
	end
end

class Game

	CHOICES = {"P" => "Paper", "R" => "Rock", "S" => "Scissors"}

	attr_accessor :p1, :p2, :winner

	def initialize
		@p1 = User.new("User")
		@p2 = Computer.new("Computer")
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

	# Compares 2 player's hands and finds the winner.
	def compare(p1, p2)
		if p1.hand > p2.hand
		self.winner = p1
	elsif p2.hand > p1.hand
		self.winner = p2
	else
		self.winner = "No one"
		end
	end

	# Launches game.
	def play
		loop do
			puts "Play Paper Rock Scissors!"
			
			# Both players make move.
			p1.make_move
			p2.make_move
			puts "#{p1.name} picked #{Game::CHOICES[p1.hand.move]} and #{p2.name} picked #{Game::CHOICES[p2.hand.move]}."

			# Compare and find the winner
			compare(p1, p2)

			# Announce winner.
			self.say_winner

			# Asks if user wants to play again.
			begin
				puts "Play again? (Y/N)"
				choice = gets.chomp.upcase
  		end until ["Y", "N"].include?(choice)

  		if choice == "N"
  			break
  		end

  	end
  end

end

game = Game.new
game.play