require_relative "code_maker"

module Mastermind


class Console
    attr_accessor :game
    #attr_accessor :guess
    attr_accessor :end_of_game#false
    attr_accessor :current_guess
    attr_accessor :response
    @guess
    @secret_code #private to console or just pass as parameter
    @code_maker

    def code
        false
    end

    def put_welcome
        puts "Welcome to Mastermind"
    end

    def put_secret_code
        puts "Secret code generated #{@secret_code}"
    end
    def put_directions
        puts "Guess a code of 4 from colors { Red Yellow Blue Green Black White }, you have 7 tries to win..."
    end

    def setup
        begin
            code_maker = Mastermind::CodeMaker.new
            code_maker.generate_random_code
            secret_code = code_maker.place_generated_code#return generated code to pass to console? then console must to that is has value secret code

            @guess = []
            @response = []
            @code_maker = code_maker
            @secret_code = secret_code
            @end_of_game = false
            @current_guess = 0
        rescue StandardError => detail
            print "Setup Failed: " + detail
        end
    end

    def put_prompt(guess_num)
        puts "Enter color #{guess_num}"
    end

    def receive_input(guess)

       guess << gets.chomp
       @guess = guess
      #do a hash of guess to store all guesses
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

    def play(game)

    put_welcome
    setup
    put_secret_code
    put_directions

    while !@end_of_game do
        (1..4).each do |guess_num |
            put_prompt(guess_num)
            receive_input(@guess)
        end

        #validates guess within parameters
        @code_maker.validate_guess(@guess)
        put_guess
        receive_response
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


end

    class MockConsoleUI

    end
end

