$: << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'mastermind/console'
require 'mastermind/code_breaker'
require 'mastermind/human_breaker'
require 'mastermind/code_maker'
require 'mastermind/game'
require 'mastermind/runner'

game = Mastermind::Game.new
user_interface = Mastermind::Console.new

player = nil
if ARGV[0] == 'C'
  player = Mastermind::CodeBreaker.new
else
  player = Mastermind::HumanBreaker.new(user_interface)
end

Mastermind::Runner.new(user_interface, game, player).run
