require_relative "code_maker"
require_relative "color"

module Mastermind


class Console
    
    attr_accessor :current_guess_number
    attr_reader :response
    attr_reader :code_maker
    attr_accessor :color

    WELCOME = "Welcome to Mastermind"
    SECRET_CODE_GEN = "Secret Code has been Generated"
    DIRECTIONS = "Guess a code of 4 from colors | Red Yellow Blue Green Black White |, 8 tries to win."
    INCORRECT_COLOR_MESSAGE = "Incorrect colors, guess again using |Red Yellow Blue Green Black White|"

    def initialize
        code_maker = Mastermind::CodeMaker.new
        code_maker.generate_random_code
        code_maker.place_generated_code
        @code_maker = code_maker
        @current_guess_number = 1
        @response = []

        @color = Mastermind::Color.new
    end

    def play(game)
        out(color.magenta(WELCOME))
        out(SECRET_CODE_GEN)
        out(DIRECTIONS)
        out_secret_code(@code_maker.secret_code)

        until game.end_of_game?(@current_guess_number, @response) do
          take_turn
        end
        
        out out_won_or_lost_message(game.won?)
    end
    
    def take_turn
      out_current_guess_number(@current_guess_number)
      in_guess_from_user_with_validation
      out_secret_code(@code_maker.secret_code) #testing#
      out_guess(@code_maker.guess)
      
      @response = @code_maker.determine_and_place_response(@code_maker.guess)
      out_response(@code_maker.response)
      
      @current_guess_number += 1
    end

    def out_won_or_lost_message(game)
        if game
            "YOU WON"
        else
            "YOU LOST"
        end
    end

    def out (message)
        puts(message)
    end

    def in
       gets.chomp
    end

    def out_secret_code(secret_code)
        out "#{secret_code}"
    end

    def out_current_guess_number(current_guess_number)
        out "Guess number #{current_guess_number}"
    end

    def put_prompt(guess_num)
        out "Enter color #{guess_num}"
    end

    def in_guess_from_user_with_validation
        guess = []
        (1..4).each do |enter_color |
            put_prompt(enter_color)
            guess = receive_user_input(guess, enter_color - 1)
        end
        message = @code_maker.validate_and_place_guess(guess)
        guess_again if incorrect_color_message?(message)
    end

    
    def incorrect_color_message?(message)
      if message == 'Incorrect Color'
            out(color.red(INCORRECT_COLOR_MESSAGE))
            return true
        end
      false
    end


    def guess_again
        @current_guess_number -= 1
    end

    def receive_user_input(guess, index)
       guess[index] = gets.chomp
       guess
    end

    def out_guess(guess)
        out "Your guess is #{guess}"
    end

    def out_response(response)
        out "The response is #{response}"
    end

end


end

