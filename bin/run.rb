require_relative "../lib/mastermind/game"
require_relative "../lib/mastermind/console"


puts "Hello, I'm starting the game..."
game = Mastermind::Game.new
user_id = UserIO.new
Mastermind::Console.new.play(game)




