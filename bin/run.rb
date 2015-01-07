$: << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'mastermind/console'
require 'mastermind/code_breaker'
require 'mastermind/code_maker'
require 'mastermind/game'
require 'mastermind/runner_comp'
#require 'mastermind/runner'


#code_maker = Mastermind::CodeMaker.new
#code_breaker = Mastermind::CodeBreaker.new
game = Mastermind::Game.new
user_interface = Mastermind::Console.new

Mastermind::RunnerComp.new(user_interface, game).run
#Mastermind::Runner.new(user_interface, game).run
