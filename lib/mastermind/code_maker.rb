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


    def generate_random_code
      #generates a random code of numbers
      @random_nums = 4.times.map{Random.rand(6)}
      #print @random_nums

    end

    def place_generated_code
      #places a color code from random numbers
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
      #places a color code from parameter
      check_pegs_size secret_code
      check_colors_are_correct secret_code
      #print " secret code placed #{secret_code}"
      @secret_code = secret_code
    end

    def validate_guess(guess_array)
      process_guess = []
      process_guess = format_guess (guess_array)

      #check colors are correct - so make check_colors_are_correct more generic

      message = check_colors_are_correct(process_guess)
      if message != nil
        @message = message
        @guess = []
        return message
      end

      @guess = process_guess#don't save state and return
      process_guess
    end

    def receive_guess(guess_array)
      response = ["","","",""]#response is stored in array and returned - set response to empty for each
      hold = secret_code.clone

      guess_array.each_with_index do |guess, index|#iterate over guess_array do guess element and generate index
        if guess == secret_code[index]
          response[index] = "Black"
          guess_array[index] = "gm" #instead of deleting it, flag "matched" to keep array size the same
          secret_code[index] = "cm"
        end
      end
      #print "g",guess_array#[m m Y m]
      #print "c",secret_code#[m m B m] 
      #print "r",response   #[b b " b]   

      guess_array.each_with_index do |guess, index|
        if secret_code.include?(guess)
          response[index] = "White"
          guess_array[index] = "gm"
          index_to_match = secret_code.index(guess)
          secret_code[index_to_match] = "cm"
          #print guess_array
          #print secret_code
        end
      end
      #print guess_array
      print "before",secret_code
      #print response
      
      @secret_code = hold
      print "after",@secret_code
      @response = response.sort
      response.sort
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
          #raise InvalidCode.new("Incorrect colors")
          message = "Incorrect Color"

        end



      end
      message
    end

    def in_correct_position_and_color?(guess, index)
      guess == secret_code[index]
    end

    def has_color?(guess , index)
      secret_code.include?(guess)
    end

    def format_guess (guess_array)
      process_guess = []
      #make the colors all capitalized for all processing
      guess_array.each_index do |index|
        process_guess[index] = guess_array[index].to_s.capitalize
      end
      process_guess
    end




  end
end