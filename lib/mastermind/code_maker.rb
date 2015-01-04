module Mastermind

  class InvalidCode < Exception
  end

  class CodeMaker

    attr_accessor :secret_code, :random_nums, :response, :guess, :message

    attr_reader :color_pegs

    COLORS = %w[Red Yellow Black White Blue Green]
    GUESS_MATCH = "guess_match"
    CODE_MATCH = "code_match"
    INCORRECT_COLOR = "incorrect_color"

    def initialize
      pegs = ColorPegs.new
      @color_pegs = [
          pegs.red,
          pegs.yellow,
          pegs.blue,
          pegs.green,
          pegs.black,
          pegs.white
      ]
    end


    # @return [color_pegs]
    def color_pegs
      @color_pegs.each do |peg|
        print ' ' + peg + ' '
        ' ' + peg + ' '
      end
    end

    def place_generated_code
      secret_code =[]
      generate_random_code.each_index do |i|
        secret_code[i] = COLORS[@random_nums[i]]
      end
      check_pegs_size(secret_code)
      check_colors_are_correct(secret_code)
      @secret_code = secret_code
    end

    def place_code (secret_code)  
      check_pegs_size(secret_code)
      check_colors_are_correct(secret_code)
      @secret_code = secret_code
    end
    
    def validate(guess_array)
      processed_guess = []
      
      processed_guess = format_guess(guess_array)
      if are_colors_incorrect?(processed_guess)
        return  INCORRECT_COLOR
      end

     processed_guess
    end

    def determine_response(guess_array)
      response = ["","","",""]
      secret_code_clone = secret_code.clone
      guess_clone = guess_array.clone
      
      response = guess_equals_code_position_and_color(guess_clone,secret_code_clone,response)
      response = guess_contains_code_color(guess_clone,secret_code_clone, response)
      #puts secret_code.inspect
      response.sort
    end

    def are_colors_incorrect?(code_array)
      code_array.each do |code|
        if !COLORS.include?(code)
          return true
        end
      end
      false
    end


    
    private
    def generate_random_code
      @random_nums = 4.times.map{Random.rand(6)}
    end

    def check_pegs_size(code_array)
      raise InvalidCode.new("Too many pegs") if code_array.size > 4
      raise InvalidCode.new("Not enough pegs")if code_array.size < 4
    end

    def check_colors_are_correct(code_array)
      code_array.each do |code|
        if !COLORS.include?(code)
          raise InvalidCode.new("Incorrect Color")
        end
      end
    end

    def guess_equals_code_position_and_color(guess_clone,secret_code_clone,response)

      guess_clone.each_with_index do |guess, index|
        if guess == secret_code_clone[index]

          response[index] = "Black"
          guess_clone[index] = GUESS_MATCH
          secret_code_clone[index] = CODE_MATCH#refrencing the same thing when secret_code assigned to guess_array?

        end
      end

      response
    end

    def guess_contains_code_color(guess_array, secret_code_clone, response)
      guess_array.each_with_index do |guess, index|
        if secret_code_clone.include?(guess)
          response[index] = "White"
          guess_array[index] = GUESS_MATCH
          index_to_match = secret_code_clone.index(guess)
          secret_code_clone[index_to_match] = CODE_MATCH
        end
      end
      response
    end

    def in_correct_position_and_color?(guess, index)
      guess == secret_code[index]
    end

    def format_guess (guess_array)
      process_guess = []
      guess_array.each_index do |index|
        process_guess[index] = guess_array[index].to_s.capitalize.strip
      end
      process_guess
    end

  end
end