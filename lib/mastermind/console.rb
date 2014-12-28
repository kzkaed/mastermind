require_relative "code_maker"

module Mastermind


class Console
    
    attr_accessor :current_guess
    attr_reader :response

    @code_maker
    @secret_code
    @guess
    @message
    

    def initialize
        setup
        @current_guess = 1
        @response = []
    end

    def setup
        code_maker = Mastermind::CodeMaker.new
        code_maker.generate_random_code
        secret_code = code_maker.place_generated_code

        @code_maker = code_maker
        @secret_code = secret_code

        @guess = []
        #@response = []
    end


    def play(game)
        guess = []
        response = []
        
        put_welcome
        put_secret_code_generated
        put_directions
    
        #why do I need response passed? response is an empty array
        while !game.end_of_game?(@current_guess, @response) do
            put_current_guess_num

            validated_guess = gets_validated_guess_from_user (guess)

            put_secret_code #testing#
            put_guess

            @response = @code_maker.receive_guess(@code_maker.guess)#receive_response

            put_response
            
            @current_guess += 1
           
        end
        
    end
    def out (message)
        puts (message)
    end

    def in
       message =  gets.chomp
    end
    
    def put_welcome
        puts "Welcome to Mastermind"
    end

    def put_secret_code_generated#
        puts "Secret code generated"
    end

    def put_directions
        puts "Guess a code of 4 from colors | Red Yellow Blue Green Black White |, 8 tries to win."
    end

    def put_secret_code
        puts "#{@secret_code}"
    end


    def put_prompt(guess_num)
        puts "Enter color #{guess_num}"
    end

    #here
    def gets_validated_guess_from_user (guess)
        (1..4).each do |guess_num |
            put_prompt(guess_num)
            guess = receive_input(guess, guess_num - 1)
        end
        validated_guess = if_wrong_color_message_guess_again(guess)
    end 

    def receive_input(guess, guess_index)
       guess[guess_index] = gets.chomp
       guess
    end

    def if_wrong_color_message_guess_again(guess)
        message = validate_guess(guess)
        if message == 'Incorrect Color'
            put_incorrect_colors_message
            guess_again
        end
        guess
    end

    def validate_guess (guess)
        message = @code_maker.validate_guess(guess)
    end

    def put_guess
        puts "Your guess is #{@code_maker.guess}"
    end

    def put_response
        puts "The response is #{@code_maker.response.inspect}"
    end

    def receive_response
        @response = @code_maker.receive_guess(@code_maker.guess)
    end

    def put_current_guess_num
        puts "Guess number #{@current_guess}"
    end

    def guess_again
        @current_guess -= 1
    end

    def put_incorrect_colors_message
        puts "Incorrect Colors"
    end

end


end

