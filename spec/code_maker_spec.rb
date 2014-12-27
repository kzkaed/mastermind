require 'spec_helper'
require 'mastermind/code_maker'


describe Mastermind::CodeMaker do

  let(:code_maker) { described_class.new }


  it 'place secret code pegs' do
    code_maker.place_code(["Red", "Red", "Red", "Red"])
    expect(code_maker.secret_code).to match_array(["Red", "Red", "Red", "Red"])

  end


  it 'makes sure the secret code parameter is 4' do
    expect {code_maker.place_code(["Red", "Red", "Red", "Red", "Red"])}.to raise_error(Mastermind::InvalidCode, "Too many pegs")
    expect {code_maker.place_code(["Red","Red","Red"])}.to raise_error(Mastermind::InvalidCode,"Not enough pegs")
  end


  it 'random number should be between 0 and 5' do
    code_maker.generate_random_code
    expect(code_maker.random_nums[0]).to be_between(0, 5)
    expect(code_maker.random_nums[1]).to be_between(0, 5)
    expect(code_maker.random_nums[2]).to be_between(0, 5)
    expect(code_maker.random_nums[3]).to be_between(0, 5)
  end


  it 'secret code should be colors from COLORS' do
    code_maker.random_nums = [1, 2, 3, 4]
    code_maker.place_generated_code
    expect(code_maker.secret_code).to include "Yellow", "Black", "White", "Blue"
  end



  it 'all guesses are processed in capitalize format' do
    code_maker.validate_guess(["red","RED","reD", "Red"])
    expect(code_maker.guess).to match_array(["Red","Red","Red","Red"])
  end


  it 'returns message if guess is not a correct color in validate_guess' do
    code_maker.validate_guess(["Cyan","Red","Red" "Red"])
    expect(code_maker.message).to eq("Incorrect Color")
  end

  it 'sets guess to empty if guess is not correct color in validate_guess' do
    code_maker.validate_guess(["Cyan","Red","Red" "Red"])
    expect(code_maker.guess).to eq([])

  end

  it 'place code secret code should match @secret_code' do
    expect(code_maker.place_code(["Red","Blue","Yellow","Yellow"])).to eq(code_maker.secret_code)
  end


  it 'guess is all one color and code is random' do
    code_maker.secret_code = ["Red","Blue","Yellow","Yellow"]
    expect(code_maker.receive_guess(["Red", "Red", "Red", "Red"])).to match_array(["Black","","",""])
  end

  it 'guesses 1 black match' do
    code_maker.secret_code = ["Red", "Red", "Red", "Red"]
    expect(code_maker.receive_guess(["Red","Green","Yellow","Blue"])).to match_array(["Black", "","",""])

  end


  it 'guesses 2 black match' do
    code_maker.secret_code = ["Red", "Red", "Red", "Red"]
    expect(code_maker.receive_guess(["Red","Red","Yellow","Blue"])).to match_array(["Black","Black","",""])
  end

  it 'guesses 1 match with yellow and index offset' do
    code_maker.secret_code = ["Yellow", "Blue", "Yellow", "Yellow"]
    expect(code_maker.receive_guess(["Yellow","Yellow","Blue","Blue"])).to match_array(["Black","White","White",""])

  end

  it 'guesses 4 match with red' do
    code_maker.secret_code = ["Red", "Red", "Red", "Red"]
    expect(code_maker.receive_guess(["Red","Red","Red","Red"])).to match_array(["Black","Black","Black","Black"])
  end

  it 'guesses right color and wrong spot returns white' do
    code_maker.secret_code = ["Red", "Blue", "Green", "Yellow"]
    expect(code_maker.receive_guess(["White","Red","White","White"])).to match_array(["","White", "", ""])
  end

  it 'verifies that secret code is original code after receive_guess' do
    code_maker.secret_code = ["Red", "Red", "Red", "Red"]
    expect(code_maker.receive_guess(["Red","Red","Red","Red"])).to match_array(["Black","Black","Black","Black"])
    expect(code_maker.secret_code).to match_array(["Red", "Red", "Red", "Red"])

  end
######
#  if there are duplicate colours in the guess, they cannot all be awarded a key peg unless they correspond to the same
#number of duplicate colours in the hidden code. For example, if the hidden code is white-white-black-black and the
#player guesses white-white-white-black, the codemaker will award two colored key pegs for the two correct whites,
#nothing for the third white as there is not a third white in the code, and a colored key peg for the black. No
#indication is given of the fact that the code also includes a second black.[5]
##
  it 'if duplicate colors in guess, cannot be awarded a key peg' do
    code_maker.secret_code = ["White", "White", "Black", "Black"]
    expect(code_maker.receive_guess(["White","White","White","Black"])).to match_array(["Black","Black", "", "Black"])

  end


  it 'if duplicate colors in guess, cannot be awarded key peg in different order' do
    code_maker.secret_code = ["Yellow","Black","Black","Yellow"]
    expect(code_maker.receive_guess(["Yellow","Black","Yellow","Yellow"])).to match_array(["Black","Black", "", "Black"])
  end



  end
