require 'spec_helper'
require 'mastermind/console'
require 'mastermind/user_io'
require 'mastermind/color_string'
require 'stringio'

describe Mastermind::Console do


  let(:console) { described_class.new }

  let(:color_string) { described_class.new }
  let(:color_pegs) { described_class.new }

  before do
    $stdout = StringIO.new
    $stdin = StringIO.new
  end
  after(:all) do
    $stdout = STDOUT
    $stdin = STDIN
  end

  it 'prints out game staring messages' do
    expect(console.prepare).to eq(nil)
  end


  it 'uses out to put a message to the console' do
    console.out('a message')
    expect($stdout.string).to match('a message')
  end

  it 'uses console in to get message from user via console' do
    $stdin.string = 'message'
    expect(console.in).to match('message')
  end

  it 'defines constants for primary console messages' do
    expect(Mastermind::Console::WELCOME).to eq("Welcome to Mastermind")
    expect(Mastermind::Console::SECRET_CODE_GEN).to eq('Secret Code has been Generated')
    expect(Mastermind::Console::INCORRECT_COLOR_MESSAGE).to eq("Incorrect colors, guess again")
    expect(Mastermind::Console::INCORRECT_COLOR).to eq("incorrect_color")
  end

  it 'puts to console WELCOME using out' do
    message = Mastermind::Console::WELCOME
    console.out(message)
    expect($stdout.string).to eq(message+"\n")
  end

  it 'puts to console SECRET_CODE_GEN using out' do
    message = Mastermind::Console::SECRET_CODE_GEN
    console.out(message)
    expect($stdout.string).to eq(message+"\n")
  end

   it 'puts to console INCORRECT_COLOR_MESSAGE using out' do
    message = Mastermind::Console::INCORRECT_COLOR_MESSAGE
    console.out(message)
    expect($stdout.string).to eq(message+"\n")
   end


  
  it 'checks for INCORRECT_COLOR message' do
   guess = ["Red","Red","Red","Red"]
   expect(console.incorrect_color_message?(guess)).to eq(false)
   expect(console.incorrect_color_message?(Mastermind::Console::INCORRECT_COLOR)).to eq(true)
 end

  it 'prepares startup messages' do
    console.prepare
    string1 = "\e[35mWelcome to Mastermind\e[0m\n"
    string2 = "Secret Code has been Generated\n"
    string3 = "Guess code of 4 from colors"
    string4 = "  \033[31mRed\033[0m  \033[33mYellow\033[0m  \033[34mBlue\033[0m  \033[32mGreen\033[0m  \033[30mBlack\033[0m  \033[37mWhite\033[0m "
    string5 = ", 8 tries to win.\n"
    expect($stdout.string).to eq("#{string1}#{string2}#{string3}#{string4}#{string5}")
  end
  
  it 'lets the user know what the current guess number is' do
    console.display_current_turn(4)
    expect($stdout.string).to eq("Guess number 4\n")
  end

  it 'puts to console guess' do
    console.out_guess(["Red", "Red", "Red", "Red"])
    expect($stdout.string).to eq("Your guess is  \033[31mRed\033[0m  \033[31mRed\033[0m  \033[31mRed\033[0m  \033[31mRed\033[0m \n")
  end

  it 'puts to console response' do
    console.out_response(["", "", "White", "Black"])
    expect($stdout.string).to eq("The response is  o  o  \033[37mWhite\033[0m  \033[30mBlack\033[0m \n")
  end

  it 'puts to console secret code' do
    console.out_secret_code(["Red", "Red", "Red", "Red"])
    expect($stdout.string).to eq("The secret code  \033[31mRed\033[0m  \033[31mRed\033[0m  \033[31mRed\033[0m  \033[31mRed\033[0m \n")
  end

  it 'puts user prompt message: Enter color 1' do
    console.put_prompt(1)
    expect($stdout.string).to match("Enter color 1")
  end

  it 'puts user prompt message: Enter color 4' do
    console.put_prompt(4)
    expect($stdout.string).to match("Enter color 4")
  end


it 'displays game result' do
  console.display_game_result(true,["Red","Yellow", "Blue", "Green"])
  expect($stdout.string).to match("YOU WON")
end



it 'receives guess input' do
  $stdin.string = "Blue"
  expect(console.in_guess).to eq(["Blue",nil, nil, nil])
end



  it 'translates the string arrays to color output' do

      expect(console.translate_to_color_pegs(["Red","Red","Red","Red"])).to eq([
                                                                              "\033[31mRed\033[0m",
                                                                              "\033[31mRed\033[0m",
                                                                              "\033[31mRed\033[0m",
                                                                              "\033[31mRed\033[0m"])

  end



  it 'formats output to console in color return a string' do
    expect(console.format_out([
                                  "\033[31mRed\033[0m",
                                  "\033[31mRed\033[0m",
                                  "\033[31mRed\033[0m",
                                  "\033[31mRed\033[0m"])).to eq(" \033[31mRed\033[0m  \033[31mRed\033[0m  \033[31mRed\033[0m  \033[31mRed\033[0m ")
  end

  it 'out formatted string to out' do
    string_from_format_out = " \033[31mRed\033[0m  \033[31mRed\033[0m  \033[31mRed\033[0m  \033[31mRed\033[0m "
    console.out(string_from_format_out)
    expect($stdout.string).to eq(" \033[31mRed\033[0m  \033[31mRed\033[0m  \033[31mRed\033[0m  \033[31mRed\033[0m \n")
  end

  it 'return horizontal array of all color pegs' do
    output_array = console.translate_to_color_pegs(["Red","Yellow","Blue","Green","Black","White"])
    expect(console.format_out(output_array)).to eq( " \033[31mRed\033[0m  \033[33mYellow\033[0m  \033[34mBlue\033[0m  \033[32mGreen\033[0m  \033[30mBlack\033[0m  \033[37mWhite\033[0m ")
  end

end