require 'spec_helper'
require 'mastermind/console'
require 'mastermind/user_io'
require 'mastermind/color'
require 'stringio'

describe Mastermind::Console do


  let(:console) { described_class.new }
  let(:color) { described_class.new }

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
    expect(Mastermind::Console::INCORRECT_COLOR_MESSAGE).to eq("Incorrect colors, guess again using |Red Yellow Blue Green Black White|")
    expect(Mastermind::Console::DIRECTIONS).to eq("Guess a code of 4 from colors | Red Yellow Blue Green Black White |, 8 tries to win.")
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

    it 'puts to console DIRECTIONS using out' do
    message = Mastermind::Console::DIRECTIONS
    console.out(message)
    expect($stdout.string).to eq(message+"\n")
  end
  
  it 'checks for INCORRECT_COLOR message' do
   guess = ["Red","Red","Red","Red"]
   expect(console.incorrect_color_message?(guess)).to eq(false)
   expect(console.incorrect_color_message?(Mastermind::Console::INCORRECT_COLOR)).to eq(true)
 end

  it 'puts to out INCORRECT_COLOR_MESSAGE' do
    console.incorrect_color_message?('Incorrect Color')
    expect($stdout.string).to match(Mastermind::Console::INCORRECT_COLOR_MESSAGE)
  end
  
  it 'prepares startup messages' do
    string_to_color = "Welcome to Mastermind"
    string = "\33[35m#{string_to_color}\033[0m"
    stringprint = string + "\nSecret Code has been Generated"+"\nGuess a code of 4 from colors | Red Yellow Blue Green Black White |, 8 tries to win.\n"
    console.prepare
    expect($stdout.string).to eq(stringprint)
  end
  
  it 'lets the user know what the current guess number is' do
    console.display_current_turn(4)
    expect($stdout.string).to eq("Guess number 4\n")
  end

  it 'puts to console guess from code_maker' do
    console.out_guess(["Red", "Red", "Red", "Red"])
    expect($stdout.string).to eq("Your guess is [\"Red\", \"Red\", \"Red\", \"Red\"]\n")
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
  console.display_game_result(true)
  expect($stdout.string).to match("YOU WON")
end

it 'receives guess input' do
  $stdin.string = "Blue"
  expect(console.in_guess).to eq(["Blue",nil, nil, nil])
end


end