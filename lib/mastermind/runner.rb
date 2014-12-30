require 'mastermind/game'

module Mastermind
  class Runner
    attr_accessor :game
    attr_reader :current_turn
    attr_reader :response
    
    def initialize(user_interface, game)
      @user_interface = user_interface
      @game = game
      @current_turn = 0
      @response = []
    end
    
    def run
      @user_interface.prepare
      
      until game.end_of_game?(@current_turn, @response) do
        # take_turn
      end

    end
    
  end
end