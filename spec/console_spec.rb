require 'spec_helper'
require 'mastermind/console'
require 'mastermind/user_io'
require 'stringio'

describe Mastermind::Console do


  let(:console) { described_class.new }

  before do
    $stdout = StringIO.new
    $stdin = StringIO.new
  end
  after(:all) do
    $stdout = STDOUT
    $stdin = STDIN
  end



  it '@code_maker is initialized' do
    expect(console.code_maker).not_to be_nil
  end

  it '@current_guess is  1 at initialization' do
    expect(console.current_guess_number).to eq(1)
  end

  it '@response is initialized to an empty array' do
    expect(console.response).to eq([])
  end


  it 'uses console out to put a message to the console' do
    console.out('a message')
    expect($stdout.string).to match('a message')
  end

  it 'uses console in to get message from user via console' do
    $stdin.string = 'message'
    expect(console.in).to match('message')
  end

  it 'defines constants for primary console messages' do
    expect(Mastermind::Console::WELCOME).to eq("Welcome to Mastermind")
  end

  it 'uses constants to pass to out' do
    console.out(Mastermind::Console::WELCOME)
    expect($stdout.string).to eq("Welcome to Mastermind\n")
  end

  it 'also defines other constants for console messages' do
    expect(Mastermind::Console::SECRET_CODE_GEN).to eq('Secret Code has been Generated')
    expect(Mastermind::Console::INCORRECT_COLOR_MESSAGE).to eq("Incorrect colors, guess again using |Red Yellow Blue Green Black White|")
    expect(Mastermind::Console::DIRECTIONS).to eq("Guess a code of 4 from colors | Red Yellow Blue Green Black White |, 8 tries to win.")
  end

  it 'puts to console any code' do
    console.out_secret_code('a code')
    expect($stdout.string).to match('a code')
  end

  it 'puts secret code from code_maker to console' do
    code = console.code_maker.secret_code
    console.out_secret_code(code)
    expect($stdout.string).to eq("#{code}\n")
  end

  it 'lets the user know what the current guess number is' do
    current_guess_number = console.current_guess_number
    console.out_current_guess_number(current_guess_number)
    expect($stdout.string).to eq("Guess number #{current_guess_number}\n")
  end

  it 'puts to console guess from code_maker' do
    guess = console.code_maker.guess
    console.out_guess(guess)
    expect($stdout.string).to eq("Your guess is #{guess}\n")
  end

  it 'guess is code_maker guess' do
    guess = console.code_maker.guess
    expect(console.code_maker.guess).to eq(guess)
  end


  it 'puts user prompt message: Enter color 1' do
    console.put_prompt(1)
    expect($stdout.string).to match("Enter color 1")
  end

  it 'puts user prompt message: Enter color 4' do
    console.put_prompt(4)
    expect($stdout.string).to match("Enter color 4")
  end




  it 'console receives input and places in guess at index ' do
      $stdin.string = "Blue"
      expect(console.receive_user_input(["Red","Red","Red","Red"], 0)).to eq(["Blue","Red","Red","Red"])
      $stdin.string = "Blue"
      expect(console.receive_user_input(["Red","Red","Red","Red"], 1)).to eq(["Red","Blue","Red","Red"])
      $stdin.string = "Blue"
      expect(console.receive_user_input(["Red","Red","Red","Red"], 2)).to eq(["Red","Red","Blue","Red"])
      $stdin.string = "Blue"
      expect(console.receive_user_input(["Red","Red","Red","Red"], 3)).to eq(["Red","Red","Red","Blue"])
  end

  it 'receives input and places in guess at index with empty guess array fill with nil' do
    $stdin.string = "Blue"
    expect(console.receive_user_input([], 0)).to eq(["Blue"])
    $stdin.string = "Blue"
    expect(console.receive_user_input([], 1)).to eq([nil,"Blue"])
    $stdin.string = "Blue"
    expect(console.receive_user_input([], 2)).to eq([nil,nil,"Blue"])
    $stdin.string = "Blue"
    expect(console.receive_user_input([], 3)).to eq([nil,nil,nil,"Blue"])

  end



  it 'message checks for message' do
    expect(console.check_and_guess_again?('')).to eq(false)
    expect(console.check_and_guess_again?('Incorrect Color')).to eq(true)

  end



  it 'guess again by decrement current_guess' do
    console.current_guess_number = 2
    console.guess_again
    expect(console.current_guess_number).to eq(1)
  end






end