require_relative 'code_maker'
require_relative 'color_string'
require_relative 'pegs'

module Mastermind
  class InvalidCode < Exception
  end
class Console
    
    
    attr_accessor :color_string
    attr_reader :game, :incorrect_color_message, :console_color_pegs, :console_key_pegs

    WELCOME = 'Welcome to Mastermind'
    SECRET_CODE_GEN = 'Secret Code has been Generated'
    DIRECTIONS = 'Guess a code of 4 from colors | Red Yellow Blue Green Black White |, 8 tries to win.'
    INCORRECT_COLOR_MESSAGE = 'Incorrect colors, guess again using |Red Yellow Blue Green Black White|'
    INCORRECT_COLOR = 'incorrect_color'
    def initialize
        
        @color_string = Mastermind::ColorString.new

        pegs = Mastermind::Pegs.new
        @console_color_pegs = pegs.console_color_pegs#hash
        @console_key_pegs = pegs.console_key_pegs
        @incorrect_color_message = color_string.red(INCORRECT_COLOR_MESSAGE)
        @welcome = color_string.magenta(WELCOME)
    end
    
    def prepare
      out(@welcome)
      out(SECRET_CODE_GEN)
      out(DIRECTIONS)
    end

    def display_response(guess, response)
      out_guess(guess)
      out_response(response)
    end



    def display_current_turn(guess_number)
      out_current_guess_number(guess_number)
    end

# this should partly be in game
# how to fully test this - use a stub or mock
    def in_guess_from_user_with_validation(game)
      guess = ["","","",""]
      while (guess == ["","","",""])
        guess = in_guess
        guess = game.validate(guess)
        if incorrect_color_message?(guess)
          out(@incorrect_color_message)
          guess = ["","","",""]
        end
      end
      guess
    end

    def incorrect_color_message?(guess)#private?
      return true if guess == INCORRECT_COLOR
      false
    end

    def display_game_result(result,secret_code)
      if result == true
        out("YOU WON")
      else
        out("YOU LOST")
        out_secret_code(secret_code)
      end
    end


    def out (message)
      puts(message)
    end

    def in_guess#private?
      guess = []
      (1..4).each do |prompt_num|
        put_prompt(prompt_num)
        guess << gets
      end
      guess
    end

    def put_prompt(guess_num)#private?
      out "Enter color #{guess_num}"
    end

    def out_current_guess_number(current_guess_number)
      out "Guess number #{current_guess_number}"
    end

    def out_guess(guess)
      color_output_array = translate_to_color_pegs(guess)
      color_output_string = format_out(color_output_array)
      out "Your guess is #{color_output_string}"
    end

    def out_response(response)
      key_output_array = translate_to_key_pegs(response)
      key_output_string = format_out(key_output_array)
      out "The response is #{key_output_string}"
    end

    def out_secret_code(secret_code)
      color_output_array = translate_to_color_pegs(secret_code)
      color_output_string = format_out(color_output_array)
      out "The secret code #{color_output_string}"
    end

    def in
      gets.chomp
    end



      def format_out(output_array)
        color_output_string = ""
        output_array.each do |color|
          color_output_string << ' ' + color + ' '
        end
        color_output_string
      end



    def translate_to_color_pegs(color_array)
      #guess["Red","Red","Red","Red"] or secret_code
      color_output_array = []
      color_array.each do |color|
        color_output_array << @console_color_pegs[color]
      end
      color_output_array
    end

  def translate_to_key_pegs(key_array)
    #response ["","","White","Black"]
    key_output_array = []
    key_array.each do |key|
      key_output_array << @console_key_pegs[key]
    end
    key_output_array
  end





  private






end

end

