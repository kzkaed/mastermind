require_relative 'code_maker'
require_relative 'color_string'
require_relative 'pegs'

module Mastermind
  class InvalidCode < Exception
  end
class Console
    
    attr_accessor :color_string
    attr_reader :game, :incorrect_color_message, :console_color_pegs, :console_key_pegs

    COLORS = %w(Red Yellow Blue Green Black White)
    WELCOME = 'Welcome to Mastermind'
    SECRET_CODE_GEN = 'Secret Code has been Generated'
    INCORRECT_COLOR_MESSAGE = 'Incorrect colors, guess again'
    INCORRECT_COLOR = 'incorrect_color'

    def initialize
        @color_string = Mastermind::ColorString.new
        pegs = Mastermind::Pegs.new
        @console_color_pegs = pegs.console_color_pegs
        @console_key_pegs = pegs.console_key_pegs
        @incorrect_color_message = color_string.red(INCORRECT_COLOR_MESSAGE)
        @welcome = color_string.magenta(WELCOME)
        format_out(translate_to_color_pegs(COLORS))
        @directions = "Guess code of 4 from colors #{format_out(translate_to_color_pegs(COLORS))}, 8 tries to win."
    end
    
    def prepare
      out(@welcome)
      out(SECRET_CODE_GEN)
      out(@directions)
    end

    def display_response(guess, response)
      out_guess(guess)
      out_response(response)
    end

    def display_current_turn(guess_number)
      out_current_guess_number(guess_number)
    end

    # how to fully test this - use a stub or mock
    def in_guess_validation
      guess = ["","","",""]
      while (guess == ["","","",""])
        guess = in_guess
        guess = validate(guess)
        if incorrect_color_message?(guess)
          out(@incorrect_color_message)
          guess = ["","","",""]
        end
      end
      guess
    end

    def validate(guess_array)
      processed_guess = []
      processed_guess = format_guess(guess_array)
      if are_colors_incorrect?(processed_guess)
        return  INCORRECT_COLOR
      end
      processed_guess
    end

    def format_guess (guess_array)
      process_guess = []
      guess_array.each_index do |index|
        process_guess[index] = guess_array[index].to_s.capitalize.strip
      end
      process_guess
    end

    def are_colors_incorrect?(guess_array)
      guess_array.each do |code|
        if !COLORS.include?(code)
          return true
        end
      end
      false
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
      color_output_array = []
      color_array.each do |color|
        color_output_array << @console_color_pegs[color]
      end
      color_output_array
    end

    def translate_to_key_pegs(key_array)
      key_output_array = []
      key_array.each do |key|
        key_output_array << @console_key_pegs[key]
      end
      key_output_array
    end





  private






end

end

