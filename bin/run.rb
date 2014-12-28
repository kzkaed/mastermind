require_relative "../lib/mastermind/game"
require_relative "../lib/mastermind/console"


puts "Hello, I'm starting the game..."
game = Mastermind::Game.new
console = Mastermind::Console.new
console.play(game)





