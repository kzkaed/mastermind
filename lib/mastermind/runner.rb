require 'mastermind/game'

module Mastermind
  class Runner
    attr_accessor :game
    attr_reader :response
    
    def initialize(user_interface, game, player)
      @user_interface = user_interface
      @game = game
      @player = player
      @response = []
    end
    
    def run
      @user_interface.prepare
      @game.generate_code
      
      until @game.end_of_game?(@game.current_turn, @response) do
        @user_interface.display_current_turn(@game.current_turn)
        guess = @player.guess(@response)
        @response = @game.take_turn(guess)
        @user_interface.display_response(guess, response)
      end
      
      @user_interface.display_game_result(@game.won?(response), @game.secret_code)
    end
    
  end
end