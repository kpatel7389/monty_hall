# Utility class for the simulation of a single Monty Hall game.
class MontyHall
	def initialize
		@doors = ['car', 'goat', 'goat'].sort_by { rand }
	end

	# Return a number representing the player's first choice.
	def door_num
		return rand(3)
	end

	# Return the index of the door opened by the host.
	# This cannot represent a door hiding a car or the player's chosen door.
	def open_door(pick)
		num_of_doors = [0, 1, 2]
		num_of_doors.delete(pick)
		num_of_doors.delete(@doors.index('car'))
		return num_of_doors.sort_by { rand }.first
	end

	# Return true if the player won by staying
	# with their first choice, false otherwise.
	def staying_pick_wins?(pick)
		won?(pick)
	end

	# Return true if the player won by switching, false otherwise.
	def switching_pick_wins?(pick, open_door)
		switched_pick = ([0, 1, 2] - [open_door, pick]).first
		won?(switched_pick)
	end

	private

	# Return true if the player's final pick hides a car, false otherwise.
	def won?(pick)
		@doors[pick] == 'car'
	end
end

if __FILE__ == $0
	ITERATIONS = (ARGV.shift || 1_000_000).to_i
	staying = 0
	switching = 0
	ITERATIONS.times do
		monty_hall = MontyHall.new
		picked = monty_hall.door_num
		revealed = monty_hall.open_door(picked)
		staying += 1 if monty_hall.staying_pick_wins?(picked)
		switching += 1 if monty_hall.switching_pick_wins?(picked, revealed)
	end
	staying_percent = (staying.to_f / ITERATIONS) * 100
	switching_percent = (switching.to_f / ITERATIONS) * 100
	puts "Staying: #{staying_percent}%."
	puts "Switching: #{switching_percent}%."
end