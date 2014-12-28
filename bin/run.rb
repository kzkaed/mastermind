require_relative "../lib/mastermind/game"
require_relative "../lib/mastermind/console"


puts "Hello, I'm starting the game..."
game = Mastermind::Game.new
#user_io = Mastermind::UserIO.new
console = Mastermind::Console.new
console.play(game)





