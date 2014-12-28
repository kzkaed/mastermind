require 'spec_helper'
require 'mastermind/console'
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

  it 'puts to console message: Welcome to Mastermind' do
    console.put_welcome
    expect($stdout.string).to match("Welcome to Mastermind")
  end

  it 'puts to console message: secret code generated' do
    console.put_secret_code_generated
    expect($stdout.string).to match("Secret code generated")
  end

  it 'puts to console message: directions' do
    console.put_directions
    expect($stdout.string).to match("Guess a code of 4 from colors | Red Yellow Blue Green Black White |, 8 tries to win.")
  end

  it 'puts user prompt message: Enter color 1' do
    console.put_prompt(1)
    expect($stdout.string).to match("Enter color 1")
  end

  it 'puts user prompt message: Enter color 4' do
    console.put_prompt(4)
    expect($stdout.string).to match("Enter color 4")
  end


  it 'puts to console the secret code' do
    console.put_secret_code
    expect($stdout.string).to match("#{@secret_code}")
  end

  it 'puts a message to the conole' do
    console.out("a message")
    expect($stdout.string).to match("a message")
  end

  it 'receives message from user via console' do
     $stdin.string = 'message'
     expect(console.in).to match('message')
  end

  #here
  xit 'gets validated guess from user' do
    $stdin.string = "red"


  end

   it 'puts to console message Incorrect Colors if message exist'do
     console.put_incorrect_colors_message
     expect($stdout.string).to match('Incorrect Color')
   end

  it 'console receives input and places in guess at index 0' do
      $stdin.string = "Blue"
      expect(console.receive_input(["Red","Red","Red","Red"], 0)).to match(["Blue","Red","Red","Red"])
  end

  it '@response is an empty array at setup' do
    console.setup
    expect(console.response).to eq([])
  end

  it '@response is initialized to an empty array' do
    expect(console.response).to eq([])
  end

  it 'guess again by decrement current_guess' do
    console.current_guess = 2
    console.guess_again
    expect(console.current_guess).to eq(1)
  end



  xit 'receive_response should return response' do

  end

  it 'makes new Mastermind::CodeMaker object and assigns to code_maker in setup' do
    expect{console.setup}.not_to raise_error
  end

  it 'current_guess is  1 in setup' do
    console.setup
    expect(console.current_guess).to eq(1)
  end

end