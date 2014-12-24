require_relative "code_maker"

module Mastermind


class Console
    attr_accessor :game
    #attr_accessor :guess
    attr_accessor :end_of_game#false
    attr_accessor :current_guess
    attr_reader :response
    #attr_reader :code_maker

    #private to console - can not read or write
    @code_maker
    @secret_code
    @guess
    @message
    #@response

=begin
    def initialize(io)
        @io = io
    end
=end
    def initialize
        setup
    end

    def setup #why not just initialize

            code_maker = Mastermind::CodeMaker.new
            code_maker.generate_random_code
            secret_code = code_maker.place_generated_code#return generated code to pass to console? then console must to that is has value secret code

            @guess = []
            @response = []

            @code_maker = code_maker
            @secret_code = secret_code

            @end_of_game = false
            @current_guess = 0

    end


    def play(game)
        guess = []
        response = []
        put_welcome#
        put_secret_code_generated#
        put_secret_code #testing#
        put_directions#

        while !@end_of_game do
            (1..4).each do |guess_num |
                put_prompt(guess_num)#
                guess = receive_input(guess, guess_num - 1)#test user input via MockIO
            end


            validated_guess = check_for_color_message(guess)


            put_secret_code #testing#

            put_guess

            @response = @code_maker.receive_guess(@code_maker.guess)#receive_response

            put_response

            #increments guess
            @current_guess += 1
            put_current_guess_num

            #checks if game over
            @end_of_game = game_over(@current_guess, @response)
        end
        @game = game
    end


    def game_over(current_guess, response)
        guess_max = 8

        if current_guess == guess_max
            end_of_game = true
            puts "YOU LOST!"
            put_secret_code
        else
            if response == ["Black", "Black", "Black", "Black"]
                puts "YOU WON!"
                end_of_game = true
            else
                end_of_game = false
            end
        end
        end_of_game

    end

    def check_for_color_message(guess)
        message = validate_guess(guess)
        if message == 'Incorrect Color'
            put_incorrect_colors_message
            get_guess_again
        end
        guess
    end

    def get_guess_again

    end

    def put_incorrect_colors_message
        puts "Incorrect Colors"
    end
    def put_welcome
        puts "Welcome to Mastermind"
    end

    def put_secret_code_generated
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

    def receive_input(guess, guess_index)
       guess[guess_index] = gets.chomp
       guess
      #do a hash of guess to store all guesses
    end

    def make_guess_container (guess, count)
        #guesses_all = {}
        #guesses_all << guess, count
        #hold off on this for now, next iteration
    end

    def put_response
        puts "The response is #{@code_maker.response.inspect}"
    end

    def receive_response
        #check guess against code and return pegs
        @response = @code_maker.receive_guess(@code_maker.guess)
    end

    def put_current_guess_num
        puts "Guess number #{@current_guess}"
    end

    def put_guess
        puts "Your guess is #{@code_maker.guess}"
    end

    def validate_guess (guess)
        #validates guess within parameters - validate outside of loop?
        message = @code_maker.validate_guess(guess)#also saves guess in CodeMaker- hmm best place to keep it?
    end






end


end

