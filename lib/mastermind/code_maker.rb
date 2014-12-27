module Mastermind

  class InvalidCode < Exception
  end

  class CodeMaker
    #read/write public?
    #attr_accessor :secret_code
    def secret_code
      @secret_code
    end
    def secret_code=(value)
      @secret_code = value
    end

    def code_holder
      @code_holder
    end

    def code_holder=(value)
      @code_holder = value
    end

    attr_accessor :random_nums
    attr_accessor :response
    attr_accessor :guess
    attr_accessor :message


    COLORS = ["Red", "Yellow", "Black", "White", "Blue", "Green"]#5
    GUESS_MATCH = "guess_match"
    CODE_MATCH = "code_match"

    def generate_random_code
      @random_nums = 4.times.map{Random.rand(6)}
    end

    def place_generated_code
      
      secret_code =[]
      @random_nums.each_index do |i|
        secret_code[i] = COLORS[@random_nums[i]]
      end
      check_pegs_size secret_code
      check_colors_are_correct secret_code
      @secret_code = secret_code
      secret_code
    end

    def place_code (secret_code)  
      check_pegs_size secret_code
      check_colors_are_correct secret_code
      @secret_code = secret_code
    end

    def validate_guess(guess_array)
      process_guess = []
      process_guess = format_guess (guess_array)

      message = check_colors_are_correct(process_guess)
      if message != nil
        @message = message
        @guess = []
        return message
      end

      @guess = process_guess
    end

    def receive_guess(guess_array)
      response = ["","","",""] 
      hold_original_secret_code = secret_code.clone

      guess_array.each_with_index do |guess, index|
        if guess == secret_code[index]
          response[index] = "Black"
          guess_array[index] = GUESS_MATCH
          secret_code[index] = CODE_MATCH
        end
      end

      guess_array.each_with_index do |guess, index|
        if secret_code.include?(guess)
          response[index] = "White"
          guess_array[index] = GUESS_MATCH
          index_to_match = secret_code.index(guess)
          secret_code[index_to_match] = CODE_MATCH         
        end
      end
  
      @secret_code = hold_original_secret_code
      @response = response.sort
    end

    private

    def check_pegs_size(code_array)
      raise InvalidCode.new("Too many pegs") if code_array.size > 4
      raise InvalidCode.new("Not enough pegs")if code_array.size < 4
    end

    def check_colors_are_correct(code_array)
      message = nil
      code_array.each do |code|

        if !COLORS.include?(code)
          message = "Incorrect Color"
        end
      end
      message
    end

    def in_correct_position_and_color?(guess, index)
      guess == secret_code[index]
    end

    def has_color?(guess)
      secret_code.include?(guess)
    end

    def format_guess (guess_array)
      process_guess = []
      guess_array.each_index do |index|
        process_guess[index] = guess_array[index].to_s.capitalize
      end
      process_guess
    end

  end
end