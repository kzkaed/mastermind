$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'mastermind/console'
require 'mastermind/game'
require 'mastermind/runner'

game = Mastermind::Game.new
user_interface = Mastermind::Console.new

Mastermind::Runner.new(user_interface, game).run
