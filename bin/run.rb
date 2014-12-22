require_relative "../lib/mastermind/game"
require_relative "../lib/mastermind/console"

#puts ARGV.inspect


puts "Hello, I'm starting the game..."
game = Mastermind::Game.new
#user_id = UserIO.new
Mastermind::Console.new.play(game)

##
# start a game. Mastermind::Game.new
#
# while !game.over?
#   get a guess from the user game.submit_guess(guess)
#   print out the result for the user's guess
# end
#
# print out the results for the whole game


